# frozen_string_literal: true

class CreateChatParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_participations do |t|
      t.belongs_to :chat_room
      t.belongs_to :user

      t.boolean :archived, default: false

      t.timestamps
    end
  end
end
