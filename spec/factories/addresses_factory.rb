FactoryBot.define do
  factory :address do
    association :person

    street { ::Faker::Name.name }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    postal_code { Faker::Address.postcode }
  end
end
