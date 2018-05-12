require 'administrate/base_dashboard'

class CategoryDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    required_items: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    name: Field::String,
    color: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    name
    color
    required_items
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    color
    required_items
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    color
    required_items
  ].freeze
end
