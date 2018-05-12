require 'administrate/base_dashboard'

class RequestDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    decisions: Field::HasMany,
    required_items: Field::HasMany,
    categories: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    title: Field::String,
    description: Field::Text,
    status: Field::Select.with_options(collection: Request.statuses.values),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    photo_file_name: Field::String,
    photo_content_type: Field::String,
    photo_file_size: Field::Number,
    photo_updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    title
    status
    user
    decisions
    required_items
    categories
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    title
    description
    status
    user
    categories
    decisions
    required_items
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    title
    description
    status
    user
    decisions
    required_items
  ].freeze
end
