# frozen_string_literal: true

require_dependency 'request/operation/find'

class Request
  class Confirm < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Request::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :confirm?)

    step ->(_, model:, **) { model.confirmed! }
    step ->(context, **) { context['success_message'] = I18n.t('views.messages.request.confirmed') }

    step ::Trailblazer::Operation::CreateActivity(action: :confirm)

    finally ::Trailblazer::Operation::HandleAlerts
  end
end
