# frozen_string_literal: true

require_dependency 'request/operation/index'

class Request
  module Declined
    class Index < ::Application::Operation
      step ::Trailblazer::Operation::Policy::Pundit(::RequestPolicy, :index?)

      step :set_params!
      step :set_finder_keys!

      step ::Trailblazer::Operation::Finder(Request::Finder, :all, ::Request)

      failure ::Trailblazer::Operation::HandleAlerts

      def set_params!(_ctx, params:, **)
        params.merge!(f: { status: ::Request::DECLINED, sort: 'updated_at desc' })
      end

      def set_finder_keys!(context, **)
        context['finder.keys'] = %i[user_id]
      end
    end
  end
end
