class CarsController < ApplicationController

	def index
		if session[:user_id]
			@user = User.find(session[:user_id]) #variable user si estoy en sesion
		end
		@cars = Car.all
	end
end
