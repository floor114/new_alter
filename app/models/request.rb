class Request < ApplicationRecord
  STATUSES = [
    ACTIVE = :active,
    ARCHIVED = :archived,
    UNCINFIRMED = :unconfirmed,
    DECLINED = :declined
  ].freeze
  enum status: STATUSES

  belongs_to :user
end
