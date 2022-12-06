class UsersController < ApplicationController
	require 'json'

	def show
  		@user = User.find(params[:id])
	end
	
	def update_rango
		@user = User.find(params[:id])
		@user.update(rango: params[:rango])
		render action: "index", notice: 'Rango cambiado'
	end

	def baja_y_alta_supervisores #Tambien sirve para desbloquear usuarios.
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

	# recibe un metodo post desde la vista de recuperar contrasenia
	def enviar_mail_recuperar_contrasenia
		mail = request.params['email']
		@user = User.find_by email: mail
		if @user != nil
			puts @user.name
			if PasswordMailer.with(user: @user).reset_password.deliver_now
				redirect_to new_user_password_path, notice: 'Se ha enviado un correo con un enlace para restablecer su contraseña'

			end
		else
			redirect_to new_user_password_path, alert: 'El e-mail ingresado no se encuentra registrado'
		end
	end
end
