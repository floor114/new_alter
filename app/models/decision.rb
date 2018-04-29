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

  def ended?
    rejected? || accepted? || partly_accepted?
  end
end
