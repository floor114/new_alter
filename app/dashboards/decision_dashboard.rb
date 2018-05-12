require 'administrate/base_dashboard'

class DecisionDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    request: Field::BelongsTo,
    accepted_items: Field::HasMany,
    required_items: Field::HasMany,
    categories: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    description: Field::Text,
    status: Field::Select.with_options(collection: Decision.statuses.values),
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    user
    request
    accepted_items
    required_items
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    description
    categories
    status
    user
    request
    accepted_items
    required_items
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    description
    status
    user
    request
    required_items
  ].freeze
end
