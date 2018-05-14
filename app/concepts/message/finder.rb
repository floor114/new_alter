class Message
  class Finder < ::Application::Finder
    entity_type { Message }

    sortable_by :created_at, :updated_at

    filter_by :receiver_id
    filter_by :receiver_type
  end
end
