# frozen_string_literal: true

class Decision < ApplicationRecord
  enum status: {
    created: CREATED = 'created',
    read: READ = 'read',
    rejected: REJECTED = 'rejected',
    accepted: ACCEPTED = 'accepted',
    partly_accepted: PARTLY_ACCEPTED = 'partly_accepted'
  }

  belongs_to :user
  belongs_to :request
  has_many :accepted_items, dependent: :destroy, autosave: true
  has_many :required_items, through: :request
  has_many :categories, through: :accepted_items

  def ended?
    rejected? || accepted? || partly_accepted?
  end
end
