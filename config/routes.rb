Rails.application.routes.draw do
  resources :payments
  get 'billetera', to: 'billetera#mercadopago'
  get 'billetera/pago', to: 'billetera#create'
  get 'static_pages/home_logged_user'
  post '/payment/notification' => 'payments#receive_and_update'


  resources :cars
  resources :rents
  resources :payments

  devise_for :users, components: {registrations: 'registrations', sessions: 'sessions'} #Las de devise siempre tienen que estar encima de las de USER

  resources :users, only: [:show]

  resources :users do
	  member do
	  	patch :update_rango
		patch :baja_y_alta_supervisores
		patch :bloquear_usuario
	  end
  end

  resources :rents do
	member do
		patch :terminar_alquiler
	end
  end

  resources :cars do
	member do
		patch :dar_de_baja
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
