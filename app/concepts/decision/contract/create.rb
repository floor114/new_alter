# frozen_string_literal: true

class Decision
  class Contract
    class Create < Reform::Form
      include Reform::Form::ModelReflections

      DESTROY_MARK = '1'

      model Decision

      collection :accepted_items,
                 form: ::AcceptedItem::Contract::Create,
                 populate_if_empty: AcceptedItem,
                 prepopulator: ->(*) { accepted_items.append(AcceptedItem.new) },
                 skip_if: :skip_condition?

      properties :description, :request

      validates :description, :request, :accepted_items, presence: true

      private

      def skip_condition?(fragment:, **)
        fragment[:_destroy] == DESTROY_MARK
      end
    end
  end
end
