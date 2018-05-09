# frozen_string_literal: true

class Request < ApplicationRecord
  enum status: {
    confirmed: CONFIRMED = 'confirmed',
    archived: ARCHIVED = 'archived',
    unconfirmed: UNCONFIRMED = 'unconfirmed',
    declined: DECLINED = 'declined'
  }

  has_attached_file :photo, styles: { medium: '300x300>', thumb: '100x100>' },
                            default_url: 'missing-photo.jpg'
  validates_attachment_content_type :photo, content_type: %r{\Aimage\/.*\z}

  belongs_to :user
  has_many :decisions, dependent: :destroy
  has_many :required_items, dependent: :destroy, autosave: true
  has_many :categories, through: :required_items
end
