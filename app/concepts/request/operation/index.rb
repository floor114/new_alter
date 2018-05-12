# frozen_string_literal: true

class Request
  class Index < ::Application::Operation
    step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :index?)

    step :set_finder_defaults!

    step ::Trailblazer::Operation::Finder(::Request::Finder, :all)

    failure ::Trailblazer::Operation::HandleAlerts

    def set_finder_defaults!(context, **)
      context['finder.defaults'] = { status: ::Request::CONFIRMED, sort: 'created_at desc' }
    end
  end
end
