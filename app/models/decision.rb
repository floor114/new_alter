# frozen_string_literal: true

class Decision < ApplicationRecord
  enum status: {
    created: CREATED = 'created',
    read: READ = 'read',
    rejected: REJECTED = 'rejected',
    accepted: ACCEPTED = 'accepted',
    partly_accepted: PARTLY_ACCEPTED = 'partly_accepted'
  }

  IN_PROGRESS = [CREATED, READ].freeze

  belongs_to :user
  belongs_to :request
  has_many :accepted_items, dependent: :destroy, autosave: true
  has_many :required_items, through: :request
  has_many :categories, through: :accepted_items
  has_one :receiver, through: :request, source: :user

  def ended?
    rejected? || accepted? || partly_accepted?
  end
end
