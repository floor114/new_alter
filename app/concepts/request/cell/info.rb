# frozen_string_literal: true

class Request
  class Cell
    class Info < ::Application::Cell
      property :title, :user, :created_at, :description

      DESCRIPTION_LENGTH_IN_LIST = 530

      def description_block
        return truncated_description_block if list?

        simple_format(description, class: 'description')
      end

      private

      def truncated_description_block
        content_tag(:p, class: 'description description-list') do
          description.truncate(DESCRIPTION_LENGTH_IN_LIST, separator: ' ')
        end
      end
    end
  end
end
