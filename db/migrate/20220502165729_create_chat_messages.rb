# frozen_string_literal: true

class CreateChatMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_messages do |t|
      t.belongs_to :chat_room
      t.belongs_to :user

      t.text :content

      t.timestamps
    end
  end
end
