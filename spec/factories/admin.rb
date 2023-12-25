FactoryBot.define do
  factory :admin do
    association :ward
    name { Faker::Name.name }
    password { Faker::Lorem.characters(number: 10) }
  end
end