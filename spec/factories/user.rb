FactoryBot.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence(:email) { |n| "alter.user+#{n}@example.com" }
    password Faker::Internet.password(20)
    confirmed_at Time.zone.now
    role User::VOLUNTEER

    trait :administrator do
      role User::ADMINISTRATOR
    end

    trait :moderator do
      role User::MODERATOR
    end

    trait :newsmaker do
      role User::NEWSMAKER
    end

    trait :banned do
      role User::BANNED
    end
  end
end
