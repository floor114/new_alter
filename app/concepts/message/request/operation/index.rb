# frozen_string_literal: true

class Message
  class Request
    class Index < ::Application::Operation
      step ::Trailblazer::Operation::Policy::Pundit(::MessagePolicy, :request_index?)

      step :set_finder_defaults!

      step ::Trailblazer::Operation::Finder(::Message::Finder, :all)

      failure ::Trailblazer::Operation::HandleAlerts

      def set_finder_defaults!(context, params:, **)
        context['finder.defaults'] = {
          receiver_type: ::Request.name,
          receiver_id: params[:request_id],
          sort: 'created_at desc'
        }
      end
    end
  end
end
