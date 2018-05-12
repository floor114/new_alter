# frozen_string_literal: true

class Decision
  class Index < ::Application::Operation
    step ::Trailblazer::Operation::Policy::Pundit(::DecisionPolicy, :index?)

    step :set_finder_defaults!

    step ::Trailblazer::Operation::Finder(::Decision::Finder, :all)

    failure ::Trailblazer::Operation::HandleAlerts

    def set_finder_defaults!(context, current_user:, **)
      context['finder.defaults'] = {
        status: ::Decision::IN_PROGRESS,
        sort: 'created_at desc',
        receiver_id: current_user.id
      }
    end
  end
end
