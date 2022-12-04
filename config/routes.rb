Rails.application.routes.draw do
  resources :payments
  get 'static_pages/home_logged_user'
  get '/tickets', to: 'tickets#index'

  post '/paymentNotification', to: 'payments#receive_and_update'
  post '/tickets/new', to: 'tickets#create'

  post '/password/reset', to: 'users#enviar_mail_recuperar_contrasenia'

  resources :cars
  resources :rents
  resources :payments
  resources :tickets
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
