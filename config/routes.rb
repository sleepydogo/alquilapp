Rails.application.routes.draw do

	#Rutas comunes
	resources :users
	resources :cars
	
	#Rutas sesiones (no las entiendo)
	get '/login', to: 'sessions#login'
	post '/login', to: 'sessions#create' 
	get '/logout', to: 'sessions#destroy' #no se si es necesario
	post '/logout', to: 'sessions#destroy' #no se si es necesario
	delete '/logout', to: 'sessions#destroy'

	#Para la busqueda
  
	# ROOT
   	root "sessions#login"
end
