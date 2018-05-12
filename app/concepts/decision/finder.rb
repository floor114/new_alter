class Decision
  class Finder < ::Application::Finder
    entity_type { Decision }

    sortable_by :created_at, :updated_at

    filter_by :status, with: :apply_status
    filter_by :receiver_id, with: :apply_receiver_id

    private

    def apply_status(relation, value)
      relation.where(status: value)
    end

    def apply_receiver_id(relation, value)
      relation.eager_load(:request).where(requests: { user_id: value })
    end
  end
end
