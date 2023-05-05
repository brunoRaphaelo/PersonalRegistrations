puts 'Filling the database with people ⏳'

10.times.each do |number|
  new_person = ::Person.new
  new_person.name = ::Faker::Name.name
  new_person.email = Faker::Internet.email
  new_person.phone = "554#{Faker::Number.number}"
  new_person.birth_date = Date.today - number.days
  new_person.save!
end

puts 'Finished creating people ✅'

puts 'Filling the database with addresses ⏳'

::Person.all.each do |person|
  new_address = person.addresses.new
  new_address.street = Faker::Name.name
  new_address.city = Faker::Address.city
  new_address.state = Faker::Address.state
  new_address.country = Faker::Address.country
  new_address.postal_code = Faker::Address.postcode
  new_address.save
end

puts 'Finished creating addresses ✅'