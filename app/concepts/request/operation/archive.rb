# frozen_string_literal: true

require_dependency 'request/operation/find'

class Request
  class Archive < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Request::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :archive?)

    step ->(_, model:, **) { model.archived! }
    step ->(context, **) { context['success_message'] = I18n.t('views.messages.request.archived') }

    finally ::Trailblazer::Operation::HandleAlerts
  end
end
