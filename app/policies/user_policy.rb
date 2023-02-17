# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def created_events?
    record.is_organizer?
  end
end
