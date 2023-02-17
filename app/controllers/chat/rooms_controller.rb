# frozen_string_literal: true

module Chat
  class RoomsController < ApplicationController
    def index
      @rooms = Chat::Room.by_participant(current_user)
    end

    def show
      @room = Chat::Room.find(params[:id])
    end

    def create
      user = User.find(params[:user_id])

      @room = Chat::Room.by_participants(current_user, user).first

      if @room.nil?
        @room = Chat::Room.create
        @room.participants << current_user
        @room.participants << user
        @room.save
      end
      redirect_to @room
    end
  end
end
