# frozen_string_literal: true

class Request
  class Cell
    class RequiredItemProgress < ::Application::Cell
      property :category, :goal

      # TODO: remove dummy methods
      def current_count
        @current_count ||= rand(goal)
      end

      def progress
        (current_count.to_f / goal.to_f * 100).to_i
      end
    end
  end
end
