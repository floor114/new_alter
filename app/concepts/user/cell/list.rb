# frozen_string_literal: true

class User
  class Cell
    class List < ::Application::Cell
      property :avatar, :role, :full_name, :phone_number

      def info_block(field, klass, icon)
        return if field.blank?

        content_tag(:p, class: "info-field #{klass}") do
          content_tag(:i, nil, class: "fa fa-#{icon}") + field
        end
      end
    end
  end
end
