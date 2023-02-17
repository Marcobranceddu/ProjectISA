# frozen_string_literal: true

class MaxParticipantsNotification < Noticed::Base
  deliver_by :database

  param :event

  # Define helper methods to make rendering easier.
  def message
    'One of your events has reached the maximum number of participants.'
  end

  def url
    events_path(params[:event])
  end
end
