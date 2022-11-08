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
    if(!(user_signed_in?) || ((current_user.rango == 'No_Aceptado') || (current_user.rango == 'A_Verificar') || (current_user.rango == 'Baneado') ) )
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




end
