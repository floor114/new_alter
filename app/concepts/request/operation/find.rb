# frozen_string_literal: true

class Request
  class Find < ::Application::Operation
    step ::Trailblazer::Operation::Model(::Request, :find_by)
    failure :not_found!

    failure ::Trailblazer::Operation::HandleAlerts

    def not_found!(context, **)
      context['error_message'] = t('activerecord.errors.models.request.attributes.base.not_found')
    end
  end
end
