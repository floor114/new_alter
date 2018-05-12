# frozen_string_literal: true

require_dependency 'decision/operation/find'

class Decision
  class Reject < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Decision::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::DecisionPolicy, :reject?)

    step ->(_, model:, **) { model.rejected! }
    success :update_helped_count!
    step ->(context, **) { context['success_message'] = I18n.t('views.messages.decision.rejected') }

    finally ::Trailblazer::Operation::HandleAlerts

    def update_helped_count!(_ctx, model:, **)
      model.accepted_items.update_all(helped_count: ::AcceptedItem::ZERO_HELP) # rubocop:disable all
    end
  end
end
