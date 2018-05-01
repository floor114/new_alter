# frozen_string_literal: true

class Decision
  class Index < ::Application::Operation
    step :model!

    step ::Trailblazer::Operation::Policy::Pundit(::DecisionPolicy, :index?)

    failure ::Trailblazer::Operation::HandleAlerts

    def model!(context, current_user:, **)
      context['model'] = current_user.received_decisions.order(:status, created_at: :desc)
    end
  end
end
