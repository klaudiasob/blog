FactoryBot.define do
  factory :owner do
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end