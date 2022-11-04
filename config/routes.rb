Rails.application.routes.draw do
  get 'billetera/mercadopago'
  get 'static_pages/home_logged_user'
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

  root to: "static_pages#home"
end
