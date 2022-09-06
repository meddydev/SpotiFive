require_relative '../../lib/refresh_tokens'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
