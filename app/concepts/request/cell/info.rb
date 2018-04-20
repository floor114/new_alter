class Request
  class Cell
    class Info < ::Application::Cell
      property :title, :user, :created_at, :description

      def description_block
        simple_format(truncated_description, class: description_block_class)
      end

      private

      def truncated_description
        list? ? description.truncate(530, separator: ' ') : description
      end

      def description_block_class
        list? ? 'description description-list' : 'description'
      end
    end
  end
end
