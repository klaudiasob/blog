FactoryBot.define do
  factory :conversation do
    association :sender, factory: :owner
    association :recipient, factory: :owner
  end
end