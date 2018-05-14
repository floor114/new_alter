class Message
  class Request
    class Create < ::Application::Operation
      class Present < ::Application::Operation
        step ::Trailblazer::Operation::Model(::Message, :new)

        step ::Trailblazer::Operation::Contract::Build(constant: Message::Request::Contract::Create)

        success :assign_request!

        step ::Trailblazer::Operation::Policy::Pundit(::MessagePolicy, :request_create?)
        failure ::Trailblazer::Operation::HandleAlerts, fail_fast: true

        def assign_request!(_ctx, model:, params:, **)
          model.receiver = ::Request.find_by(id: params[:request_id])
        end
      end

      step ::Trailblazer::Operation::Nested(::Message::Request::Create::Present)
      step ::Trailblazer::Operation::AssignCurrentUser

      step ::Trailblazer::Operation::Contract::Validate(key: :message)
      failure ::Trailblazer::Operation::HandleAlerts

      step ::Trailblazer::Operation::Contract::Persist()
    end
  end
end
