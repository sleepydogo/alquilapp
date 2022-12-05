class PasswordMailer < ApplicationMailer
    default from: email_address_with_name('no-reply@alquilapp.com', 'Soporte Tecnico Alquilapp') 
    def reset_password
        @user = params[:user]
        @url = 'https://38fc-181-169-178-229.sa.ngrok.io'
        mail(to: @user.email, subject: 'Cambio de contraseña')
    end
end
