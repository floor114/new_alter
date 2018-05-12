FactoryBot.define do
  factory :accepted_item do
    count Faker::Number.number(2)
    helped_count nil
    decision
    required_item
  end
end
