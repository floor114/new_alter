FactoryBot.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence(:email) { |n| "alter.user+#{n}@example.com" }
    password Faker::Internet.password(20)
    confirmed_at Time.zone.now
    role User::VOLUNTEER
  end

  User.roles.each do |key, value|
    trait key do
      role value
    end
  end
end
