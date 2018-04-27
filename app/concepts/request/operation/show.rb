# frozen_string_literal: true

class Request
  class Show < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Request::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :show?)
  end
end
