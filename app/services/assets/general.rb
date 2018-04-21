# frozen_string_literal: true

module Assets
  class General < Base
    private

    def path
      @path ||= "#{controller&.split('/')&.first}.#{type}"
    end
  end
end
