# frozen_string_literal: true

class Decision
  class Show < ::Application::Operation
    step ::Trailblazer::Operation::Nested(::Decision::Find)

    step ::Trailblazer::Operation::Policy::Pundit(::DecisionPolicy, :show?)

    step ->(_, model:, **) { model.read! }
  end
end
