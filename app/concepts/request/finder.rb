class Request
  class Finder < ::Application::Finder
    entity_type { Request }

    sortable_by :created_at, :updated_at

    filter_by :user_id
    filter_by :status
  end
end
