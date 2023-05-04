# frozen_string_literal: true

class AddressSerializer < ActiveModel::Serializer
  attributes :id,
             :person,
             :street,
             :state,
             :city,
             :postal_code,
             :country

  def person
    return unless object.person_id

    {
      id: object.person_id,
      name: object.person_name
    }
  end
end
