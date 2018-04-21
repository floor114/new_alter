class Request
  class Contract
    class Create < Reform::Form
      properties :title, :description

      validates :title, presence: true, length: { maximum: 150 }
      validates :description, presence: true

      # TODO: Add request progress validation
      # validate :without_required_items?, on: :create, :if => proc { |r| r.required_items.empty? }
    end
  end
end
