class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    attributes = [:dni, :genero, :birthdate, :telephone, :email, :password, :password_confirmation, :name, :file, :rango]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  

  def ensure_adm
    if( (user_signed_in?) && !(current_user.rango == 'Admin'))
      redirect_to root_path
    end
  end
  helper_method :ensure_adm
  

  def destruir_docu
		if(current_user.rango == 'No_Aceptado')
			current_user.file.purge
		end
	end
  helper_method :destruir_docu


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

  def ensure_user
    if(!(@user.id == current_user.id))
      redirect_to root_path
    end
  end
  helper_method :ensure_user

  def ensure_not_empty
    if(user_signed_in?)
      redirect_to root_path
    end
  end
  helper_method :ensure_not_empty

  def ensure_renting
    if(current_user.alquilando)
      redirect_to root_path
    end
  end
  helper_method :ensure_renting

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
  
  def esta_en_LP
    @car = Rent.find(params[:id]).car
    points = []
    points << Geokit::LatLng.new("-34.953870", "-57.952073")
    points << Geokit::LatLng.new("-34.936172", "-57.932483")
    points << Geokit::LatLng.new("-34.917481", "-57.913090")
    points << Geokit::LatLng.new("-34.902048", "-57.933242")
    points << Geokit::LatLng.new("-34.887068", "-57.954214")
    points << Geokit::LatLng.new("-34.906173", "-57.975110")
    points << Geokit::LatLng.new("-34.923029", "-57.993184")
    points << Geokit::LatLng.new("-34.938827", "-57.972390")
    polygon = Geokit::Polygon.new(points)
    ubicacionAuto = Geokit::LatLng.new(@car.lat, @car.lng)
    if (polygon.contains?(ubicacionAuto))
      return true
    else
      return false
    end
  end
  helper_method :esta_en_LP  

  def pasaron_12h(finish_time)
    if((finish_time + 12.hours) > Time.now)
      return false
    else
      return true
    end
  end
  helper_method :pasaron_12h

end
