class Activity
  class Finder < ::Application::Finder
    entity_type { PublicActivity::Activity }

    sortable_by :created_at, :updated_at

    filter_by :trackable_id
    filter_by :trackable_type
  end
end
