class Person < ApplicationRecord
  # Has many associations
  has_many :addresses, inverse_of: :person, with_foreign_key: :person_id, dependent: :destroy

  # Validations
  validates :name, :email, :phone, :birth_date, presence: true
  validates :status, numericality: { only_integer: true }
  validates :discount_accepted, inclusion: { in: [true] }

  # Callbacks
  before_validation :generate_uuid, on: :create

  def generate_uuid
    self.uuid = "p-#{::SecureRandom.uuid}"
  end
end

