class ApplicationController < ActionController::Base
  include RenderHelper

  protect_from_forgery with: :exception
end
