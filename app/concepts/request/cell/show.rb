# frozen_string_literal: true

class Request
  class Cell
    class Show < ::Application::Cell
      property :user, :photo

      def action_link(url, action, icon, options = {})
        return unless can?(action)

        link_to url, options.merge(title: t(action, scope: 'views.actions.requests')) do
          content_tag(:span, nil, class: "fa fa-#{icon}")
        end
      end
    end
  end
end
