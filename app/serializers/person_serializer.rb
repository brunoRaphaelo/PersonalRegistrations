# frozen_string_literal: true

class PersonSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :phone,
             :birth_date

  def birth_date
    object.birth_date.strftime('%d-%m-%Y')
  end
end
