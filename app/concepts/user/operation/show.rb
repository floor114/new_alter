# frozen_string_literal: true

class User
  class Show < ::Application::Operation
    step ::Trailblazer::Operation::Model(::User, :find_by)
    failure :not_found!

    step ::Trailblazer::Operation::Policy::Pundit(::UserPolicy, :show?)

    failure ::Trailblazer::Operation::HandleAlerts

    def not_found!(context)
      context['error_message'] = t('activerecord.errors.models.user.attributes.base.not_found')
    end
  end
end
