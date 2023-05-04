FactoryBot.define do
  factory :person do
    name { ::Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    birth_date { Faker::Date.birthday }
  end
end
