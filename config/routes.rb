Rails.application.routes.draw do
  resources :payments
  get 'static_pages/home_logged_user'
  get '/tickets/:id', to: 'tickets#show'
  get '/tickets', to: 'tickets#index'
  post '/paymentNotification', to: 'payments#receive_and_update'


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
    patch :dar_de_alta
	end
  end

  root to: "static_pages#home"
end
