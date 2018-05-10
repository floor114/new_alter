# frozen_string_literal: true

class AcceptedItem
  class Contract
    class PartlyAccept < Reform::Form
      include Trailblazer::Reform::Nested

      model AcceptedItem

      DESTROY_MARK = '1'

      delegate :required_item_id, :count, to: :model

      property :item, virtual: true, prepopulator: ->(*) { self.item = required_item_id }
      property :helped_count, prepopulator: ->(*) { self.helped_count = count },
                              populator: :helped_count_populator!

      validates :helped_count, numericality: { only_integer: true,
                                               greater_than: 0,
                                               less_than_or_equal_to: :count },
                               presence: true,
                               if: :accepted?

      private

      def helped_count_populator!(fragment:, **)
        self.helped_count = accepted? ? fragment : ::AcceptedItem::ZERO_HELP
      end

      def accepted?
        _destroy != DESTROY_MARK
      end
    end
  end
end
