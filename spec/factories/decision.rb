FactoryBot.define do
  factory :decision do
    description Faker::Lorem.paragraph
    user
    request
    status Decision::CREATED

    trait :read do
      status Decision::READ
    end

    trait :rejected do
      status Decision::REJECTED
    end

    trait :accepted do
      status Decision::ACCEPTED
    end

    trait :partly_accepted do
      status Decision::PARTLY_ACCEPTED
    end
  end
end
