# frozen_string_literal: true

class Request < ApplicationRecord
  enum status: {
    active: ACTIVE = 'active',
    archived: ARCHIVED = 'archived',
    unconfirmed: UNCONFIRMED = 'unconfirmed',
    declined: DECLINED = 'declined'
  }

  belongs_to :user
end
