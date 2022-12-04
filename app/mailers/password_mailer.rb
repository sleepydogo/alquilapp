class PasswordMailer < ApplicationMailer
    default from: 'no-reply@alquilapp.com'
    
    def generate_valid_token
        
    end 

    def reset_password
        @user = params[:user]
        @url = ''
        mail(to: @user.email, subject: 'Cambio de contraseña')
    end
end
