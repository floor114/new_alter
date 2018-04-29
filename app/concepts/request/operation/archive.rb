# frozen_string_literal: true

require_dependency 'request/operation/find'

class Request
  class Archive < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Request::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :archive?)

    step :archive!
    success :message!

    finally ::Trailblazer::Operation::HandleAlerts

    def archive!(_context, model:, **)
      model.archived!
    end

    def message!(context, **)
      context['success_message'] = I18n.t('views.messages.request.archived')
    end
  end
end
