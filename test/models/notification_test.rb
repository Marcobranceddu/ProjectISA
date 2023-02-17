# frozen_string_literal: true

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  test 'should have one organizer' do
    organizer = User.create(email: 'user@example.com', password: 'password', is_organizer: true)
    notification = Notification.create(recipient_id: organizer.id, recipient_type: 'User', type: 'abc')
    assert_equal organizer, User.find(notification.recipient_id)
  end
end
