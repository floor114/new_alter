require 'administrate/base_dashboard'

class RequiredItemDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    request: Field::BelongsTo,
    category: Field::BelongsTo,
    accepted_items: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    goal: Field::Number
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    request
    category
    accepted_items
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    goal
    request
    category
    accepted_items
  ].freeze

  FORM_ATTRIBUTES = %i[
    goal
    request
    category
    accepted_items
  ].freeze
end
