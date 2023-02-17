# frozen_string_literal: true

class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :user_id, uniqueness: { scope: :event_id }
  validate :validate_overlapping_event
  validate :validate_max_participants

  scope :of, ->(user) { where(user:) }
  scope :by_organizer, lambda { |organizer|
    joins(:event).where(events: { organizer: })
  }
  scope :by_event, ->(event) { where(event:) }

  def validate_overlapping_event
    # debugger
    return if event.nil?
    return unless user.joined_events.where.not(id: event.id).overlapping(event.start_date, event.end_date).any?

    errors.add(:overlap_error, 'Event overlaps with another event')
  end

  def validate_max_participants
    return if event.nil?
    return unless event.participants.count >= event.max_participants

    errors.add(:max_participants_error, 'Event is full.')
  end
end
