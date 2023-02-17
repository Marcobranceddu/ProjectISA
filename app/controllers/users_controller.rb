# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, only: [:created_events]

  def blacklist; end

  def add_to_blacklist
    user = User.find(params[:id])

    Participation.of(user).by_organizer(current_user).each do |participation|
      participation.update(is_banned: true)
    end

    current_user.blacklisted_users << user
    current_user.save

    redirect_to blacklist_url
  end

  def remove_from_blacklist
    user = User.find(params[:id])

    Participation.of(user).by_organizer(current_user).each do |participation|
      participation.update(is_banned: false)
    end

    current_user.blacklisted_users.delete(user)
    current_user.save

    redirect_to blacklist_url
  end

  def created_events
    @title = 'Created Events'
    @events = current_user.created_events

    authorize current_user
  end

  def joined_events
    @title = 'Joined Events'
    @events = current_user.joined_events
  end
end
