# frozen_string_literal: true

class Decision
  class Find < ::Application::Operation
    step ::Trailblazer::Operation::Model(::Decision, :find_by)
    failure :not_found!

    failure ::Trailblazer::Operation::HandleAlerts

    def not_found!(context, **)
      context['error_message'] = t('activerecord.errors.models.decision.attributes.base.not_found')
    end
  end
end
