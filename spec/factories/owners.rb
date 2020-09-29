# frozen_string_literal: true

FactoryBot.define do
  factory :owner do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    phone { FFaker::PhoneNumber.short_phone_number }

    trait :admin do
      admin { true }
    end
  end
end
