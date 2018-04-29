class Decision
  class Cell
    class Info < ::Application::Cell
      property :user, :created_at, :description
      delegate :request, to: :model, prefix: :decision

      def title_url_resource
        list? ? model : decision_request
      end
    end
  end
end
