FactoryBot.define do
  factory :category do
    name Faker::Lorem.word
    color Faker::Color.hex_color
  end
end
