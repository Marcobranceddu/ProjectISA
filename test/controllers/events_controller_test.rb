# frozen_string_literal: true

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  test 'should get index' do
    get '/events'
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test 'should create new event' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    before = Event.count # technically, eval("Post.count")
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
      organizer_id: 1,
      latitude: 12.211213,
      longitude: 12.211213
    }
    post '/events',
         params: {
           event: new_event, headers: { 'Content-Type' => 'application/json' }
         }
    after = Event.count
    logout(:user)
    assert_equal after, before + 1
  end

  test 'should return successful response' do
    created_event = Event.create({ name: 'Event 1', image: 'URL', start_date: '2023-01-01', end_date: '2022-10-02', max_participants: 12, street: 'Gulberg III', city: 'Lahore',
                                   state: 'Punjab', country: 'Pakistan', organizer_id: 1, latitude: 12.211213, longitude: 12.211213 })
    get "/events/#{created_event.id}"
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test 'should not save article without name' do
    event = Event.new
    assert_not event.save
  end

  test 'should delete event' do
    before = Event.count
    delete "/events/#{Event.last.id}"
    after  = Event.count
    assert_equal after, before - 1
  end
end
