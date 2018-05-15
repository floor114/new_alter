class Request
  class Cell
    class Info < ::Application::Cell
      property :title, :user, :created_at, :description, :impressionist_count

      def impressions_count
        impressionist_count(filter: :ip_address)
      end
    end
  end
end
