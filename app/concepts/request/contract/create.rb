# frozen_string_literal: true

class Request
  class Contract
    class Create < Reform::Form
      include Reform::Form::ModelReflections

      DESTROY_MARK = '1'
      TITLE_MAX_LENGTH = 150

      model Request

      collection :required_items,
                 form: ::RequiredItem::Contract::Create,
                 populate_if_empty: RequiredItem,
                 prepopulator: ->(*) { required_items.append(RequiredItem.new) },
                 skip_if: :skip_condition?

      properties :title, :description, :photo

      validates :title, presence: true, length: { maximum: TITLE_MAX_LENGTH }
      validates :description, presence: true
      validates :required_items, presence: true

      private

      def skip_condition?(fragment:, **)
        return unless fragment[:_destroy] == DESTROY_MARK

        required_items.detect { |ri| ri.id == fragment[:id] }.mark_for_destruction
      end
    end
  end
end
