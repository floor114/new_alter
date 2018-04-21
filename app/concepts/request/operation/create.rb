class Request
  class Create < ::Application::Operation
    class Present < ::Application::Operation
      step ::Trailblazer::Operation::Model(::Request, :new)

      step ::Trailblazer::Operation::Contract::Build(constant: ::Request::Contract::Create)
    end

    step ::Trailblazer::Operation::Nested(::Request::Create::Present)
    step ::Trailblazer::Operation::AssignCurrentUser

    step ::Trailblazer::Operation::Contract::Validate(key: :request_contract_create)
    failure ::Trailblazer::Operation::HandleAlerts

    step ::Trailblazer::Operation::Contract::Persist()
  end
end
