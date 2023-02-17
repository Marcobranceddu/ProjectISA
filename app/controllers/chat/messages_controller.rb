# frozen_string_literal: true

module Chat
  class MessagesController < ApplicationController
    def create
      @message = Chat::Message.new(message_params)
      @message.chat_room = Chat::Room.find(params[:room_id])
      @message.user = current_user
      @message.save
    end

    private

    def message_params
      params.require(:chat_message).permit(:content)
    end
  end
end
