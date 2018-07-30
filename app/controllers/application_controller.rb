class ApplicationController < ActionController::Base
  include Admin::SessionsHelper

  protect_from_forgery unless: -> { request.format.json? }
end
