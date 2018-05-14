# frozen_string_literal: true

class Request
  module Declined
    class Index < ::Application::Operation
      step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :index?)

      step ->(context, **) { context['finder.keys'] = %i[user_id] }
      step :set_finder_defaults!

      step ::Trailblazer::Operation::Finder(Request::Finder, :all, ::Request)

      failure ::Trailblazer::Operation::HandleAlerts

      def set_finder_defaults!(context, **)
        context['finder.defaults'] = { status: ::Request::DECLINED, sort: 'updated_at desc' }
      end
    end
  end
end
