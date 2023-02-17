# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  def create?
    user.is_organizer?
  end

  def notify?
    record.organizer == user
  end

  def destroy?
    record.organizer == user
  end
end
