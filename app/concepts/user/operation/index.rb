# frozen_string_literal: true

class User
  class Index < ::Application::Operation
    step :model!

    step ::Trailblazer::Operation::Policy::Pundit(::UserPolicy, :index?)

    failure ::Trailblazer::Operation::HandleAlerts

    def model!(context, current_user:, **)
      # TODO: move to query object
      context['model'] = User.visible(current_user).order(:created_at)
    end
  end
end
