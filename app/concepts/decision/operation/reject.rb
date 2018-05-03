# frozen_string_literal: true

require_dependency 'decision/operation/find'

class Decision
  class Reject < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Decision::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::DecisionPolicy, :reject?)

    # TODO: Implement categories rejecting logic
    step ->(_, model:, **) { model.rejected! }
    step ->(context, **) { context['success_message'] = I18n.t('views.messages.decision.rejected') }

    finally ::Trailblazer::Operation::HandleAlerts
  end
end
