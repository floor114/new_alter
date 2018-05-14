FactoryBot.define do
  factory :message do
    body Faker::Lorem.sentence
    status Message::CREATED
    user

    trait :read do
      status Message::READ
    end

    factory :request_message do
      association :receiver, factory: :request
    end
  end
end
