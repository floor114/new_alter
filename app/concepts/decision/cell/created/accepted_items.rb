class Decision
  class Cell
    module Created
      class AcceptedItems < ::Application::Cell
        property :object
        delegate :model, to: :object, prefix: :decision
        delegate :required_items, to: :decision_model
        alias_method :f, :model

        def show
          render 'created/accepted_items'
        end

        def select_options
          @select_options ||= required_items.map { |ri| [ri.category.name, ri.id] }
        end
      end
    end
  end
end
