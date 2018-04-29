# frozen_string_literal: true

require_dependency 'request/operation/find'

class Request
  class Confirm < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Request::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :confirm?)

    step :confirm!
    success :message!

    finally ::Trailblazer::Operation::HandleAlerts

    def confirm!(_context, model:, **)
      model.confirmed!
    end

    def message!(context, **)
      context['success_message'] = I18n.t('views.messages.request.confirmed')
    end
  end
end
