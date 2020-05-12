# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    body { FFaker::DizzleIpsum.sentence }
    association :conversation
    association :sender, factory: :owner
  end
end
