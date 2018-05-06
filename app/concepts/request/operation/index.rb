# frozen_string_literal: true

class Request
  class Index < ::Application::Operation
    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :index?)

    step :set_params!

    step ::Trailblazer::Operation::Finder(Request::Finder, :all, ::Request)

    failure ::Trailblazer::Operation::HandleAlerts

    def set_params!(_ctx, params:, **)
      params.merge!(f: { status: ::Request::CONFIRMED, sort: 'created_at desc' })
    end
  end
end
