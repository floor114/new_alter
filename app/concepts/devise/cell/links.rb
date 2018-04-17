module Devise
  module Cell
    class Links < ::Application::Cell
      delegate :controller_name, to: :controller

      %w[sessions registrations confirmations passwords].each do |type|
        define_method "not_#{type}?" do
          controller != type
        end
      end
    end
  end
end
