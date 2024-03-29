# frozen_string_literal: true

class User < ApplicationRecord
  include PublicActivity::Activist
  activist

  enum role: {
    administrator: ADMINISTRATOR = 'administrator',
    moderator: MODERATOR = 'moderator',
    newsmaker: NEWSMAKER = 'newsmaker',
    volunteer: VOLUNTEER = 'volunteer',
    banned: BANNED = 'banned'
  }

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             default_url: 'missing-avatar.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\z}

  has_many :requests, dependent: :destroy
  has_many :received_decisions, through: :requests, source: :decisions
  has_many :sent_decisions, class_name: Decision.name, dependent: :destroy

  scope :visible, ->(user) { where(role: [VOLUNTEER, BANNED, NEWSMAKER]).where.not(id: user&.id) }

  def full_name
    @full_name ||= "#{first_name} #{last_name}".strip
  end
end
