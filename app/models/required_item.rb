class RequiredItem < ApplicationRecord
  belongs_to :request
  belongs_to :category
  has_many :accepted_items, dependent: :destroy
end
