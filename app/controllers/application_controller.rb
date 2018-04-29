class ApplicationController < ActionController::Base
  include RenderHelper
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private

  attr_reader :model

  def _run_options(options)
    options.merge('current_user' => current_user)
  end
end
