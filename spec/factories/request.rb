FactoryBot.define do
  factory :request do
    title Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    user
    status Request::UNCONFIRMED

    Request.statuses.each do |key, value|
      trait key do
        status value
      end
    end

    trait :confirmed do
      status Request::CONFIRMED
    end

    trait :archived do
      status Request::ARCHIVED
    end

    trait :declined do
      status Request::DECLINED
    end
  end
end
