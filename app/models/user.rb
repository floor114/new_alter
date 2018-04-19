class User < ApplicationRecord
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             default_url: 'missing-avatar.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\z}

  def full_name
    @full_name ||= "#{first_name} #{last_name}"
  end
end
