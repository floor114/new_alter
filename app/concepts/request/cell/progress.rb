# frozen_string_literal: true

class Request
  class Cell
    class Progress < ::Application::Cell
      def help_link
        return if policy?(:act_as_assigned_user)
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
