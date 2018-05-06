# frozen_string_literal: true

require_dependency 'decision/operation/find'

class Decision
  class Accept < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Decision::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::DecisionPolicy, :accept?)

    # TODO: Implement categories accepting logic
    step ->(_, model:, **) { model.accepted! }
    step ->(context, **) { context['success_message'] = I18n.t('views.messages.decision.accepted') }

    finally ::Trailblazer::Operation::HandleAlerts
  end
end
