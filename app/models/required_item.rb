class RequiredItem < ApplicationRecord
  belongs_to :request
  belongs_to :category
end
