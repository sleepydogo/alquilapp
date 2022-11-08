Rails.application.routes.draw do
  get 'billetera', to: 'billetera#mercadopago'
  get 'billetera/pago', to: 'billetera#pago'
  get 'static_pages/home_logged_user'

  resources :cars
  resources :rents

  devise_for :users, components: {registrations: 'registrations', sessions: 'sessions'} #Las de devise siempre tienen que estar encima de las de USER

  resources :users, only: [:show]

  resources :users do
	  member do
	  	patch :update_rango
	  end
  end

  resources :rents do
	member do
		patch :terminar_alquiler
	end
  end

  resources :billetera do 
    member do 
      patch :crear_preferencia
    end
  end

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
