class Request
  class Update < ::Application::Operation
    class Present < ::Application::Operation
      step ::Trailblazer::Operation::Model(::Request, :find_by)

      step ::Trailblazer::Operation::Contract::Build(constant: ::Request::Contract::Create)
    end

    step ::Trailblazer::Operation::Nested(::Request::Update::Present)

    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :update?)

    step ::Trailblazer::Operation::Contract::Validate(key: :request)

    failure ::Trailblazer::Operation::HandleAlerts

    step ::Trailblazer::Operation::Contract::Persist()
  end
end
