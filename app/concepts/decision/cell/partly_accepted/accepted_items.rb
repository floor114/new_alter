class Decision
  class Cell
    class PartlyAccepted
      class AcceptedItems < ::Application::Cell
        property :object
        delegate :model, to: :object, prefix: :decision
        delegate :accepted_items, to: :decision_model
        alias_method :f, :model

        def show
          render 'partly_accepted/accepted_items'
        end

        def select_options
          @select_options ||= accepted_items.map { |ai| [ai.category.name, ai.required_item_id] }
        end
      end
    end
  end
end
