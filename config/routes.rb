Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  defaults format: :json do
    resources :addresses, only: %i[index show create update destroy], controller: 'addresses'

    resources :persons, only: %i[index show create update destroy], controller: 'persons' do
      resources :addesses, only: %i[index show], controller: 'persons/addresses'
    end
  end
end
