class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name('no-reply@alquilapp.com', 'Soporte Tecnico Alquilapp') 
  layout "mailer"
end
