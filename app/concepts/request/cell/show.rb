# frozen_string_literal: true

class Request
  class Cell
    class Show < ::Application::Cell
      property :user, :photo, :required_items, :categories, :messages, :title, :description

      def help_link
        return if policy?(:act_as_assigned_user) || !policy?(:user_exist)
        return wait_link unless policy?(:create_decision)

        link_to t('views.actions.decisions.create'), new_request_decision_path(model),
                class: 'button without-shadow', data: { modal: true }
      end

      private

      def wait_link
        button_to t('views.messages.decision.already_created'), '#', class: 'button', disabled: true
      end
    end
  end
end
