class UsersController < ApplicationController

	def show
  		@user = User.find(params[:id])
	end
	
	def update_rango
		@user = User.find(params[:id])
		@user.update(rango: params[:rango])
		render action: "index", notice: 'Rango cambiado'
	end

	def baja_y_alta_supervisores
		@user = User.find(params[:id])
		@user.update(rango: params[:rango])
		redirect_to user_url(@user), notice: 'Rango cambiado'
	end 

	def bloquear_usuario
		@user = User.find(params[:id])
		if (@user.Supervisor? && current_user.Supervisor?)
			redirect_to user_url(@user), alert: "No tiene los permisos para efectuar este bloqueo."
		elsif
			if (@user.update(rango: "Baneado"))
				redirect_to user_url(@user), notice: "Usuario bloqueado."
			end
		end
	end
	

	

end
