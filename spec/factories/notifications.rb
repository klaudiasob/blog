FactoryBot.define do
  factory :notification do

    association :recipient, factory: :owner
    association :message, factory: :message

    trait :not_readed do
      read { false }
    end

    trait :readed do
      read { true }
    end
  end
end