# frozen_string_literal: true

module Assets
  class Action < Base
    private

    def path
      @path ||= "#{[controller, action].join('/')}.#{type}"
    end
  end
end
