class Person < ApplicationRecord
  # Belongs to associations
  belongs_to :person, inverse_of: :addresses, foreign_key: :person_id

  # Validations
  validates :street, :city, :state, :country, :postal_code, presence: true
  validates :postal_code, numericality: { only_integer: true }

  # Callbacks
  before_validation :generate_uuid, on: :create

  def generate_uuid
    self.uuid = "p-#{::SecureRandom.uuid}"
  end
end

