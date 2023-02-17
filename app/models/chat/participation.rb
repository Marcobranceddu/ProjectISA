# frozen_string_literal: true

module Chat
  class Participation < ApplicationRecord
    belongs_to :chat_room, class_name: 'Chat::Room'
    belongs_to :user
  end
end
