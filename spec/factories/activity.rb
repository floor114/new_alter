FactoryBot.define do
  factory :activity, class: 'PublicActivity::Activity' do
    association :owner, factory: :user

    factory :request_activity do
      association :trackable, factory: :request
    end
  end
end
