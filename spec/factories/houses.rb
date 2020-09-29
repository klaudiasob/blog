# frozen_string_literal: true

FactoryBot.define do
  factory :house do
    association :owner

    area { rand(49..300) }
    price { rand(300_000..1_000_000) }
    description { FFaker::DizzleIpsum.sentence }
    land_area { rand(10..1000) }
    interior_finishing { %i[complete to_finish for_renovation].sample }
    available_from { Date.yesterday }
    market { %i[primary secondary].sample }

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
