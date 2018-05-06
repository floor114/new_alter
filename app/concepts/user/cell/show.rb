# frozen_string_literal: true

class User
  class Cell
    class Show < ::Application::Cell
      property :avatar, :full_name, :info, :phone_number, :role

      def info_block
        return if info.blank?

        content_tag(:p, info, class: 'description')
      end

      def phone_number_block
        return if phone_number.blank?

        content_tag(:p) do
          content_tag(:span, phone_number)
        end
      end
    end
  end
end
