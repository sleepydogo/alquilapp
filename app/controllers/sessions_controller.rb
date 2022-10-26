class SessionsController < ApplicationController

	def create
		@user = User.find_by(mail: params[:mail])
		if !!@user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect_to @user
		else
			redirect_to login_path, notice: "Te confundiste en algo"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to login_path, notice: "Sesion cerrada"
	end
end
