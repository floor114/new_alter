FactoryBot.define do
  factory :decision do
    description Faker::Lorem.paragraph
    user
    request
    status Decision::CREATED
  end

  Decision.statuses.each do |key, value|
    trait key do
      status value
    end
  end
end
