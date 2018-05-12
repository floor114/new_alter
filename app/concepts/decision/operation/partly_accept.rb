# frozen_string_literal: true

require_dependency 'decision/operation/find'

class Decision
  class PartlyAccept < ::Application::Operation
    class Present < ::Application::Operation
      step ::Trailblazer::Operation::Nested(::Decision::Find)

      step ::Trailblazer::Operation::Contract::Build(constant: ::Decision::Contract::PartlyAccept)

      step ::Trailblazer::Operation::Policy::Pundit(::DecisionPolicy, :partly_accept?)
      failure ::Trailblazer::Operation::HandleAlerts, fail_fast: true
    end

    step ::Trailblazer::Operation::Nested(::Decision::PartlyAccept::Present)

    step ::Trailblazer::Operation::Contract::Validate(key: :decision)

    step ::Trailblazer::Operation::Contract::Persist()

    step ->(_, model:, **) { model.partly_accepted! }
    step :message!

    finally ::Trailblazer::Operation::HandleAlerts

    def message!(context, **)
      context['success_message'] = I18n.t('views.messages.decision.partly_accepted')
    end
  end
end
