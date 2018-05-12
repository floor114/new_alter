require 'administrate/base_dashboard'

class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    requests: Field::HasMany,
    received_decisions: Field::HasMany.with_options(class_name: Decision.name),
    sent_decisions: Field::HasMany.with_options(class_name: Decision.name),
    id: Field::String.with_options(searchable: false),
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String.with_options(searchable: false),
    last_sign_in_ip: Field::String.with_options(searchable: false),
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    confirmation_sent_at: Field::DateTime,
    unconfirmed_email: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    first_name: Field::String,
    last_name: Field::String,
    info: Field::Text,
    phone_number: Field::String,
    avatar_file_name: Field::String,
    avatar_content_type: Field::String,
    avatar_file_size: Field::Number,
    avatar_updated_at: Field::DateTime,
    role: Field::Select.with_options(collection: User.roles.values)
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    first_name
    last_name
    email
    role
    phone_number
    requests
    sent_decisions
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    email
    first_name
    last_name
    role
    info
    phone_number
    requests
    received_decisions
    sent_decisions
    reset_password_token
    reset_password_sent_at
    remember_created_at
    sign_in_count
    current_sign_in_at
    last_sign_in_at
    current_sign_in_ip
    last_sign_in_ip
    confirmation_token
    confirmed_at
    confirmation_sent_at
    unconfirmed_email
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    email
    first_name
    last_name
    role
    info
    phone_number
    requests
    received_decisions
    sent_decisions
    reset_password_token
    reset_password_sent_at
    confirmation_token
    confirmed_at
    confirmation_sent_at
    unconfirmed_email
  ].freeze
end
