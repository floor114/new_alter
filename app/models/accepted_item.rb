class AcceptedItem < ApplicationRecord
  ZERO_HELP = 0

  belongs_to :decision
  belongs_to :required_item
  has_one :category, through: :required_item
end
