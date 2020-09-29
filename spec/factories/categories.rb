# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { FFaker::Name.name }

    trait :invalid do
      name { nil }
    end
  end
end
