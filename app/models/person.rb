class Person < ApplicationRecord
  # Has many associations
  has_many :addresses,
           inverse_of: :person,
           class_name: '::Address',
           foreign_key: :person_id,
           dependent: :destroy

  # Validations
  validates :name, :email, :phone, :birth_date, presence: true
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, if: :email_changed?
  validates :phone, uniqueness: true, length: { minimum: 11, maximum: 13 }
  validate :birth_date_range

  # Scopes
  scope :show, lambda {
    select("#{table_name}.*")
  }
  scope :by_name, lambda { |name|
    where("unaccent(#{table_name}.name) ILIKE :name",
          name: "%#{I18n.transliterate(name.downcase)}%")
  }
  scope :by_email, lambda { |email|
    where("unaccent(#{table_name}.email) ILIKE :email",
          email: "%#{I18n.transliterate(email.downcase)}%")
  }
  scope :by_phone, lambda { |phone|
    where("unaccent(#{table_name}.phone) ILIKE :phone",
          phone: "%#{I18n.transliterate(phone.downcase)}%")
  }
  scope :by_birth_date, ->(birth_date) { where(birth_date:) }

  private

  def birth_date_range
    return unless birth_date

    date_is_invalid = (birth_date < Date.today - 115.years) || birth_date > Date.today

    return unless date_is_invalid

    errors.add(:base, :invalid_date)
  end
end

