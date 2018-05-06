# frozen_string_literal: true

class Request
  class Index < ::Application::Operation
    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :index?)

    step :setup_finder!

    step ::Trailblazer::Operation::Finder(Request::Finder, :all, ::Request)

    failure ::Trailblazer::Operation::HandleAlerts

    def setup_finder!(context, **)
      context['finder.params'] = { status: ::Request::CONFIRMED, sort: 'created_at desc' }
    end
  end
end
