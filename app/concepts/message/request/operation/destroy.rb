class Message
  class Request
    class Destroy < ::Application::Operation
      step ::Trailblazer::Operation::Model(::Message, :find_by)
      failure :not_found!

      step ::Trailblazer::Operation::Policy::Pundit(::MessagePolicy, :request_destroy?)

      step ::Trailblazer::Operation::Destroy

      failure ::Trailblazer::Operation::HandleAlerts

      def not_found!(context, **)
        context['error_message'] = t('activemodel.errors.models.message.attributes.base.not_found')
      end
    end
  end
end
