# frozen_string_literal: true

class ParticipantsNotification < Noticed::Base
  deliver_by :database

  param :event
  param :content

  def message
    params[:content]
  end

  def url
    events_path(params[:event])
  end
end
