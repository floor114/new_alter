# frozen_string_literal: true

require_dependency 'decision/operation/find'

class Decision
  class PartlyAccept < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Decision::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::DecisionPolicy, :partly_accept?)

    # TODO: Implement categories accepting logic
    step ->(_, model:, **) { model.partly_accepted! }
    step :message!

    finally ::Trailblazer::Operation::HandleAlerts

    def message!(context, **)
      context['success_message'] = I18n.t('views.messages.decision.partly_accepted')
    end
  end
end
