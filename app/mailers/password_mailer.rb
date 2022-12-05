class PasswordMailer < ApplicationMailer
    default from: email_address_with_name('no-reply@alquilapp.com', 'Soporte Tecnico Alquilapp') 
    def reset_password
        @user = params[:user]
        @url = 'https://38fc-181-169-178-229.sa.ngrok.io'
        create_reset_password_token(@user)
        mail(to: @user.email, subject: 'Cambio de contraseña')
    end
    
    private
    def create_reset_password_token(user)
        raw, hashed = Devise.token_generator.generate(User, :reset_password_token)}
        @token = raw
        user.reset_password_token = hashed
        user.reset_password_sent_at = Time.now
        user.save
        puts Rails.application.routes.url_helpers.edit_user_password_url(reset_password_token: raw, host: 'localhost:3000')
    end

end
