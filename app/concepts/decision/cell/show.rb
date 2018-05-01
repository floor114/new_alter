class Decision
  class Cell
    class Show < ::Application::Cell
      property :user
      delegate :avatar, to: :user, prefix: true
    end
  end
end
