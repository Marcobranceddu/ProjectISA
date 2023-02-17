# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  test 'should add in blacklist' do
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
    Participation.create(event_id: event.id, user_id: user.id, is_banned: false)
    before = Participation.where(is_banned: false).count
    post "/blacklist/#{user.id}"
    after = Participation.where(is_banned: false).count
    assert_equal after, before - 1
  end

  test 'should remove from blacklist' do
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
    Participation.create(event_id: event.id, user_id: user.id, is_banned: true)
    before = Participation.where(is_banned: true).count
    delete "/blacklist/#{user.id}"
    after = Participation.where(is_banned: true).count
    assert_equal after, before - 1
  end
end
