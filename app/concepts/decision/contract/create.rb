class Decision
  class Contract
    class Create < Reform::Form
      model :decision

      properties :description, :request

      validates :description, :request, presence: true

      # TODO: Add decision progress validation
      # validate :without_accepted_items?, on: :create, :if => proc { |d| d.accepted_items.empty? }
    end
  end
end
