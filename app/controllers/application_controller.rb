class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = [:dni, :genero, :birthdate, :telephone, :email, :password, :password_confirmation, :name, :file]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  

  def ensure_adm
    if( (user_signed_in?) && current_user.rango == 'Usuario')
      redirect_to root_path
    end
  end
  helper_method :ensure_adm


  def ensure_sup
    if( (user_signed_in?) && current_user.rango == 'Supervisor')
      redirect_to root_path
    end
  end
  helper_method :ensure_sup

  def ensure_log
    if(!(user_signed_in?) && ((current_user.rango == 'No_Aceptado') || (current_user.rango == 'A_Verificar') || (current_user.rango == 'Baneado') ) )
      redirect_to root_path  
    end
  end
  helper_method :ensure_log

  def ensure_not_empty
    if(user_signed_in?)
      redirect_to root_path
    end
  end
  helper_method :ensure_not_empty

  def time_diff(start_time, end_time)
    seconds_diff = (start_time - end_time).to_i.abs
  
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600
  
    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60
  
    seconds = seconds_diff
  
    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
    # or, as hagello suggested in the comments:
    # '%02d:%02d:%02d' % [hours, minutes, seconds]
  end
  helper_method :time_diff
  




end
