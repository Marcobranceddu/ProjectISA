# frozen_string_literal: true

class ParticipationsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:create]

  def index
    @event = Event.find(params[:event_id])

    authorize @event, policy_class: ParticipationPolicy
  end

  def create
    event = Event.find(params[:event_id])
    @participation = Participation.new(user: current_user, event:)

    if @participation.save
      if event.participants.count == event.max_participants
        MaxParticipantsNotification.with(event:).deliver(event.organizer)
      end

      redirect_to @participation.event
    else
      @event = @participation.event
      render 'events/show', status: :unprocessable_entity
    end
  end

  def update
    @participation = Participation.find(params[:id])
    authorize @participation
    if @participation.update(is_banned: !@participation.is_banned)
      redirect_to event_participations_path(@participation.event)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @participation = Participation.find(params[:id]).destroy

    authorize @participation

    redirect_to @participation.event
  end

  def notify
    event = Event.find(params[:event_id])

    authorize event

    ParticipantsNotification.with(event:, content: params[:content]).deliver(event.participants)
  end
end
