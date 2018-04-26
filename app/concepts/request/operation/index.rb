# frozen_string_literal: true

class Request
  class Index < ::Application::Operation
    step :model!

    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :index?)

    failure ::Trailblazer::Operation::HandleAlerts

    def model!(context, **)
      context['model'] = Request.active.order(created_at: :desc)
    end
  end
end
