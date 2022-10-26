class UsersController < ApplicationController

	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id #si se guarda me pone en la sesion correspondiente al usuario [id]
			redirect_to @user #me lleva al perfil del usuario
		else
			render :new
		end
	end

	def index
		@users = User.all
		if session[:user_id]
			@user = User.find(session[:user_id]) #variable correspondiente al usuario en sesion
		end
	end

	def show
		@user = User.find(params[:id]) #se puede reemplazar con el de sesion: utiliza como variable user la que recibe del find
	end

	private
		def user_params
			params.require(:user).permit(:dni, :genero, :fecha_nacimiento, :telefono, :mail, :password)
		end
end
