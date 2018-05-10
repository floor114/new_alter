# frozen_string_literal: true

require_dependency 'decision/operation/find'

class Decision
  class Accept < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Decision::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::DecisionPolicy, :accept?)

    step ->(_, model:, **) { model.accepted! }
    success :update_helped_count!
    step ->(context, **) { context['success_message'] = I18n.t('views.messages.decision.accepted') }

    finally ::Trailblazer::Operation::HandleAlerts

    def update_helped_count!(_ctx, model:, **)
      model.accepted_items.each do |accepted_item|
        accepted_item.update(helped_count: accepted_item.count)
      end
    end
  end
end
