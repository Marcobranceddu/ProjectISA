# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  after_action :verify_authorized, except: %i[index show]

  def index
    @title = 'Events'

    @events = Event.all

    @events = @events.with_name_like(params[:query]) if params[:query].present?

    return unless params[:query_city].present?

    @events = @events.near_city(params[:query_city])
  end

  def show
    @event = Event.find(params[:id])

    if current_user
      @participation = @event.participations.find_by(user_id: current_user.id)

      room = Chat::Room.by_participants(current_user, @event.organizer).first

      @room_id = if room.nil?
                   -1
                 else
                   room.id
                 end
    end

    @title = @event.name
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = current_user.created_events.new(event_params)
    authorize @event
    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id]).destroy

    authorize @event

    redirect_to created_events_url
  end

  private

  def event_params
    params.require(:event).permit(:image, :name, :start_date, :end_date, :max_participants, :street, :city, :state,
                                  :country)
  end
end
