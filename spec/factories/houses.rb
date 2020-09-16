# frozen_string_literal: true

FactoryBot.define do
  factory :house do
    association :owner

    area { 51 }
    price { 500_000 }
    description { FFaker::DizzleIpsum.sentence }
    land_area { 10 }
    interior_finishing { :complete }
    available_from { Date.yesterday }
    market { :primary }

    trait :with_two_categories do
      transient do
        categories_count { 2 }
      end

      after(:create) do |house, evaluator|
        create_list(:category, evaluator.categories_count, houses: [house])
      end
    end

    trait :deleted do
      deleted_at { Date.yesterday }
    end

    trait :not_deleted do
      deleted_at { nil }
    end

    trait :not_valid do
      description { nil }
    end
  end
end
