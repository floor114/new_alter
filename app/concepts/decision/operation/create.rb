# frozen_string_literal: true

class Decision
  class Create < ::Application::Operation
    class Present < ::Application::Operation
      step ::Trailblazer::Operation::Model(::Decision, :new)

      step ->(_, model:, params:, **) { model.request_id = params[:request_id] }

      step ::Trailblazer::Operation::Contract::Build(constant: ::Decision::Contract::Create)

      step ::Trailblazer::Operation::Policy::Pundit(::DecisionPolicy, :create?)
      failure ::Trailblazer::Operation::HandleAlerts, fail_fast: true
    end

    step ::Trailblazer::Operation::Nested(::Decision::Create::Present)
    step ::Trailblazer::Operation::AssignCurrentUser

    step ::Trailblazer::Operation::Contract::Validate(key: :decision)

    step ::Trailblazer::Operation::Contract::Persist()

    step ->(context, **) { context['success_message'] = I18n.t('views.messages.decision.created') }

    finally ::Trailblazer::Operation::HandleAlerts
  end
end
