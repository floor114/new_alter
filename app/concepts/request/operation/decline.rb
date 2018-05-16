# frozen_string_literal: true

require_dependency 'request/operation/find'

class Request
  class Decline < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Request::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :decline?)

    step ->(_, model:, **) { model.declined! }
    step ->(context, **) { context['success_message'] = I18n.t('views.messages.request.declined') }

    step ::Trailblazer::Operation::CreateActivity(action: :decline)

    finally ::Trailblazer::Operation::HandleAlerts
  end
end
