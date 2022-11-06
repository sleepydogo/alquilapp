class UsersController < ApplicationController

	def show
  		@user = User.find(params[:id])
	end
	
	def update_rango
		@user = User.find(params[:id])
		@user.update(rango: params[:rango])
		redirect_to @user, notice: 'Rango cambiado a #{@user.rango}'
	end

	

end
