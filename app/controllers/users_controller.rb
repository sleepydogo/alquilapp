class UsersController < ApplicationController

	def show
  		@user = User.find(params[:id])
	end
	
	def update_rango
		@user = User.find(params[:id])
		@user.update(rango: params[:rango])
		render action: "index", notice: 'Rango cambiado'
	end

	

end
