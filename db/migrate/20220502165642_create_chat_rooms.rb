# frozen_string_literal: true

class CreateChatRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_rooms, &:timestamps
  end
end
