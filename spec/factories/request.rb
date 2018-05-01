FactoryBot.define do
  factory :request do
    title Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    user
    status Request::UNCONFIRMED
  end

  Request.statuses.each do |key, value|
    trait key do
      status value
    end
  end
end
