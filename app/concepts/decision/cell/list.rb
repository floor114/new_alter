# frozen_string_literal: true

class Decision
  class Cell
    class List < ::Application::Cell
      property :id, :created?, :user, :accepted_items
      delegate :avatar, to: :user, prefix: true

      def decision_class
        created? ? 'new' : ''
      end
    end
  end
end
