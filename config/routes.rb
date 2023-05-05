# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    resources :addresses, only: %i[index show create update destroy], controller: 'addresses'

    resources :people, only: %i[index show create update destroy], controller: 'people'
  end
end
