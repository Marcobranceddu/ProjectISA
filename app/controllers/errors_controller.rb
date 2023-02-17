# frozen_string_literal: true

class ErrorsController < ApplicationController
  def forbidden; end

  def not_found; end

  def internal_server_error; end
end
