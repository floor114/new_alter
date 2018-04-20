class Request
  class Show < ::Application::Operation
    step ::Trailblazer::Operation::Model(::Request, :find_by)
    failure :not_found!

    failure ::Trailblazer::Operation::HandleAlerts

    def not_found!(ctx, **)
      ctx['error_message'] = t('activerecord.errors.models.request.attributes.base.not_found')
    end
  end
end
