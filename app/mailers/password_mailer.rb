class PasswordMailer < ApplicationMailer
    default from: email_address_with_name('no-reply@alquilapp.com', 'Soporte Tecnico Alquilapp') 
    def reset_password
        @user = params[:user]
        @url = 'https://0e52-181-169-163-188.sa.ngrok.io'
        mail(to: 'xedacil703@diratu.com', subject: 'Cambio de contraseña')        
    end
end
