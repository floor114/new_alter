class Request
  class Finder < Trailblazer::Finder
    features Sorting

    adapters ActiveRecord

    entity_type { Request }

    sortable_by :created_at, :updated_at

    filter_by :user_id
    filter_by :status
  end
end
