# frozen_string_literal: true

class Address < ApplicationRecord
  # Belongs_to associations
  belongs_to :person,
             inverse_of: :addresses,
             class_name: '::Person',
             foreign_key: :person_id

  # Validations
  validates :street, :city, :state, :country, :postal_code, presence: true

  # Scopes
  scope :list, lambda {
    select("#{table_name}.*")
      .select("#{::Person.table_name}.name person_name")
      .joins(:person)
  }
  scope :show, lambda {
    select("#{table_name}.*")
      .select("#{::Person.table_name}.name person_name")
      .joins(:person)
  }
  scope :by_street, lambda { |street|
    where("unaccent(#{table_name}.street) ILIKE :street",
          street: "%#{I18n.transliterate(street.downcase)}%")
  }
  scope :by_city, lambda { |city|
    where("unaccent(#{table_name}.city) ILIKE :city",
          city: "%#{I18n.transliterate(city.downcase)}%")
  }
  scope :by_state, lambda { |state|
    where("unaccent(#{table_name}.state) ILIKE :state",
          state: "%#{I18n.transliterate(state.downcase)}%")
  }
  scope :by_country, lambda { |country|
    where("unaccent(#{table_name}.country) ILIKE :country",
          country: "%#{I18n.transliterate(country.downcase)}%")
  }
  scope :by_postal_code, ->(postal_code) { where(postal_code:) }
  scope :by_person_id, ->(person_id) { where(person_id:) }
end
