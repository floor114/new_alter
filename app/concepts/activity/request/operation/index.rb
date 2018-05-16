# frozen_string_literal: true

require_dependency 'application/operation'

class Activity
  class Request
    class Index < ::Application::Operation
      step ::Trailblazer::Operation::Policy::Pundit(::ActivityPolicy, :request_index?)

      step :set_finder_defaults!

      step ::Trailblazer::Operation::Finder(::Activity::Finder, :all)

      failure ::Trailblazer::Operation::HandleAlerts

      def set_finder_defaults!(context, params:, **)
        context['finder.defaults'] = {
          trackable_type: ::Request.name,
          trackable_id: params[:request_id],
          sort: 'created_at desc'
        }
      end
    end
  end
end
