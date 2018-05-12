class RequiredItem
  module Contract
    class Create < Reform::Form
      include Trailblazer::Reform::Nested

      model RequiredItem

      properties :goal, :category_id

      validates :goal, :category_id, presence: true
      validates :goal, numericality: { only_integer: true, greater_than: 0 }
    end
  end
end
