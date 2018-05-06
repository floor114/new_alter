class Request
  class Update < ::Application::Operation
    class Present < ::Application::Operation
      step ::Trailblazer::Operation::Nested(::Request::Find)

      step ::Trailblazer::Operation::Contract::Build(constant: ::Request::Contract::Create)

      step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :update?)
      failure ::Trailblazer::Operation::HandleAlerts, fail_fast: true
    end

    step ::Trailblazer::Operation::Nested(::Request::Update::Present)

    step ::Trailblazer::Operation::Contract::Validate(key: :request)
    failure ::Trailblazer::Operation::HandleAlerts

    step ::Trailblazer::Operation::Contract::Persist()
  end
end
