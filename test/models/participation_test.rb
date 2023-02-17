# frozen_string_literal: true

require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  test 'should not enter duplicate user' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    new_event = {
      name: 'Event 1',
      image: 'URL',
      start_date: '2023-01-01',
      end_date: '2022-10-02',
      max_participants: 12,
      street: 'Gulberg III',
      city: 'Lahore',
      state: 'Punjab',
      country: 'Pakistan',
      organizer_id: user.id,
      latitude: 12.211213,
      longitude: 12.211213
    }
    event = Event.create(new_event)
    Participation.create(user_id: user.id, event_id: event.id)
    participation_enteries2 = Participation.create(user_id: user.id, event_id: event.id)
    assert_equal({ user_id: ['has already been taken'] }, participation_enteries2.errors.messages)
  end
end
