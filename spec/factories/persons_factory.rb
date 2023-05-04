FactoryBot.define do
  factory :person do
    name { ::Faker::Name.name }
    email { Faker::Internet.email }
    phone { "554#{Faker::Number.number}" }
    birth_date { Date.today }
  end
end
