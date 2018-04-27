# frozen_string_literal: true

require_dependency 'request/operation/find'

class Request
  class Decline < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Request::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :decline?)

    step :decline!
    success :message!

    finally ::Trailblazer::Operation::HandleAlerts

    def decline!(_context, model:, **)
      model.declined!
    end

    def message!(context, **)
      context['success_message'] = I18n.t('views.messages.request.declined')
    end
  end
end
