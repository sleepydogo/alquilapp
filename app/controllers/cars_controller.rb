class CarsController < ApplicationController
	def index
		if session[:user_id]
			@user = User.find(session[:user_id]) #variable user si estoy en sesion
		end
		@cars = Car.all
		if params[:search_modelo] && params[:search_modelo] != ""
			@cars = @cars.where("modelo like ?", "#{params[:search_modelo]}%")
		end
	end

	
end
