# frozen_string_literal: true

class MessageNotification < Noticed::Base
  deliver_by :database

  param :message

  # Define helper methods to make rendering easier.
  def message
    params[:message].content
  end

  def url
    messages_path(params[:message])
  end
end
