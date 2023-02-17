# frozen_string_literal: true

module Chat
  class Message < ApplicationRecord
    belongs_to :chat_room, class_name: 'Chat::Room'
    belongs_to :user

    after_create_commit :broadcast_to_room
    after_create_commit :notify_recipients

    def broadcast_to_room
      broadcast_append_later_to(
        chat_room,
        :messages,
        target: 'messages-list',
        partial: 'chat/messages/message',
        locals: {
          message: self
        }
      )
    end

    def notify_recipients
      recipients = chat_room.participants - [user]
      MessageNotification.with(message: self).deliver(recipients)
    end
  end
end
