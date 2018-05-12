module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin!

    def authenticate_admin!
      redirect_to root_path, alert: t('errors.messages.action_not_allowed') unless
        ::UserPolicy.new(current_user).user_with_privileges?
    end
  end
end
