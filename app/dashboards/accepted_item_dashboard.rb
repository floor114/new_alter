require 'administrate/base_dashboard'

class AcceptedItemDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    decision: Field::BelongsTo,
    required_item: Field::BelongsTo,
    category: Field::HasOne,
    id: Field::String.with_options(searchable: false),
    count: Field::Number,
    helped_count: Field::Number
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    decision
    required_item
    category
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    count
    helped_count
    decision
    required_item
  ].freeze

  FORM_ATTRIBUTES = %i[
    count
    helped_count
    decision
    required_item
  ].freeze
end
