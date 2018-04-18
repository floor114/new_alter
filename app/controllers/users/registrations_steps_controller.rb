class Users::RegistrationsStepsController < ::Wicked::ApplicationController
  steps :first, :second

  def show
    render_wizard
  end

  def update; end
end
