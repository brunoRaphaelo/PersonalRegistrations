# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    person_id { create(:person).id }

    street { ::Faker::Name.name }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    postal_code { Faker::Address.postcode }
  end
end
