class Decision
  class Cell
    class Show < ::Application::Cell
      property :user, :accepted_items
      delegate :avatar, to: :user, prefix: true
    end
  end
end
