class AcceptedItem
  module Contract
    class Create < Reform::Form
      include Trailblazer::Reform::Nested

      model AcceptedItem

      properties :count, :required_item_id

      validates :count, :required_item_id, presence: true
      validates :count, numericality: { only_integer: true, greater_than: 0 }
    end
  end
end
