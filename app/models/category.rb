class Category < ApplicationRecord
  has_many :required_items, dependent: :destroy
end
