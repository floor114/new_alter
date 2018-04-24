class Request
  class Contract
    class Create < Reform::Form
      model :request

      properties :title, :description, :photo

      TITLE_MAX_LENGTH = 150

      validates :title, presence: true, length: { maximum: TITLE_MAX_LENGTH }
      validates :description, presence: true

      # TODO: Add request progress validation
      # validate :without_required_items?, on: :create, :if => proc { |r| r.required_items.empty? }
    end
  end
end
