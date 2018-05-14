class Message
  class Request
    class Cell
      class List < ::Application::Cell
        property :id, :user, :created_at, :body, :receiver
        delegate :avatar, to: :user, prefix: true
      end
    end
  end
end
