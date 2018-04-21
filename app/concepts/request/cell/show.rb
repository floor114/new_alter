class Request
  class Cell
    class Show < ::Application::Cell
      property :user, :active?

      def request_actions
        active_actions if active?
      end

      private

      def active_actions
        edit_link
      end

      def edit_link
        link_to [:edit, model], title: t('views.actions.edit') do
          content_tag(:span, nil, class: 'fa fa-pencil')
        end
      end
    end
  end
end
