Rails.application.routes.draw do
  resources :cars
  resources :rents
  devise_for :users, components: {registrations: 'registrations', sessions: 'sessions'}
  resources :users, only: [:show]
#, controllers: {
 #       sessions: 'users/sessions'
#		registrations: 'users/registrations'
#		passwords: 'users/passwords'
#		confirmations: 'users/confirmations'
 # }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "cars#index"

end
