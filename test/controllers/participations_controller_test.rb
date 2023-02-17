# frozen_string_literal: true

require 'test_helper'

class ParticipationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  # test 'should get index' do
  #   # user = FactoryBot.create(:user)
  #   # login_as(user, scope: :user)

  #   user = User.create(email: "user@example.com", password: 'password', is_organizer: true)
  #   new_event = {
  #     name: 'Event 1',
  #     image: 'URL',
  #     start_date: '2023-01-01',
  #     end_date: '2022-10-02',
  #     max_participants: 12,
  #     street: 'Gulberg III',
  #     city: 'Lahore',
  #     state: 'Punjab',
  #     country: 'Pakistan',
  #     organizer_id: user.id,
  #     latitude: 12.211213,
  #     longitude: 12.211213
  #   }
  #   event = Event.create(new_event)
  #   puts event.errors.messages
  #   puts '/events/'+event.id.to_s+'/participations'
  #   get '/events/'+event.id.to_s+'/participations'
  #   # logout(:user)
  #   assert_response :success
  #   assert_not_nil assigns(:events)
  # end

  test 'should create new event' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    before = Participation.count
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
    post "/events/#{event.id}/participations"
    after = Participation.count
    logout(:user)
    assert_equal after, before + 1
  end

  test 'should update participation data' do
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
    Participation.create(event_id: event.id, user_id: user.id)
    before = Participation.where(is_banned: true).count
    put "/participations/#{event.id}"
    after = Participation.where(is_banned: true).count
    logout(:user)
    assert_equal after, before + 1
  end

  test 'should delete participations' do
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
    participtation = Participation.create(event_id: event.id, user_id: user.id)
    before = Participation.count
    delete "/participations/#{participtation.id}"
    after  = Participation.count
    logout(:user)
    assert_equal after, before - 1
  end
end
