class Request
  class Cell
    class Info < ::Application::Cell
      property :title, :user, :created_at, :description

      def description_block
        if list?
          content_tag(:p, description.truncate(530, separator: ' '), class: 'description description-list')
        else
          simple_format(description, class: 'description')
        end
      end
    end
  end
end
