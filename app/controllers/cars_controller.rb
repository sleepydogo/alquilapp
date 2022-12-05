class CarsController < ApplicationController
  before_action :set_car, only: %i[ show edit update destroy ]

  # GET /cars or /cars.json
  def index
    if (current_user.Admin? || current_user.Supervisor?)
      @cars = Car.all
    else
	    @cars = Car.where(alquilado: false, de_baja: false)
    end
    if params[:search_modelo] && params[:search_modelo] != ""
			@cars = @cars.where("modelo like ?", "#{params[:search_modelo]}%")
     # @cars_not_rented = @cars_not_rented.where("modelo like ?", "#{params[:search_modelo]}%")
		end
    if params[:search_kilometraje] && params[:search_kilometraje] != ""
			@cars = @cars.where("kilometraje < ?", params[:search_kilometraje])
      #@cars_not_rented = @cars_not_rented.where("kilometraje < ?", params[:search_kilometraje])
		end
    if params[:search_tanque] && params[:search_tanque] != ""
			@cars = @cars.where("tanque > ?", params[:search_tanque])
      #@cars_not_rented = @cars_not_rented.where("tanque > ?", params[:search_tanque])
		end
  end

  # GET /cars/1 or /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to car_url(@car), notice: "Auto creado de manera exitosa." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to car_url(@car), notice: "Car was successfully updated." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
  set_car
  if !(@car.alquilado?)
    @car.destroy
    redirect_to cars_path, notice: "Auto eliminado de manera exitosa"
  elsif
    redirect_to car_url(@car), alert: "El auto que esta intentando eliminar se encuentra en uso."
  end
  end


  def dar_de_baja
	set_car
	if !(@car.alquilado?)
		#notice: "Auto dado de baja de manera exitosa"
		if (@car.update(de_baja: true))
			redirect_to car_url(@car), notice: "Auto dado de baja de manera exitosa"
		end
	elsif
		redirect_to car_url(@car), alert: "El auto que esta intentando dar de baja se encuentra en uso."
	end
  end

  def dar_de_alta
	  set_car
	  if (@car.de_baja?)
	  	if (@car.update(de_baja: false))
	  		redirect_to car_url(@car), notice: "Auto dado de alta de manera exitosa"
	  	end
	  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:patente, :modelo, :photo, :tanque, :kilometraje, :lat, :lng, :file)
    end  
    
end
