class ApplicationController < ActionController::Base
  include RenderHelper
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  def _run_options(options)
    options.merge(current_user: current_user)
  end
end
