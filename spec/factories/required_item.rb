FactoryBot.define do
  factory :required_item do
    goal Faker::Number.number(3)
    request
    category
  end
end
