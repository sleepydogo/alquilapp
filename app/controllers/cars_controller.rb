class CarsController < ApplicationController
  before_action :set_car, only: %i[ show edit update destroy ]

  # GET /cars or /cars.json
  def index
    @cars = Car.all
	  @cars_not_rented = Car.where(alquilado: false, de_baja: false)
    if params[:search_modelo] && params[:search_modelo] != ""
			@cars = @cars.where("modelo like ?", "#{params[:search_modelo]}%")
      @cars_not_rented = @cars_not_rented.where("modelo like ?", "#{params[:search_modelo]}%")
		end
    if params[:search_kilometraje] && params[:search_kilometraje] != ""
			@cars = @cars.where("kilometraje < ?", "#{params[:search_kilometraje]}%")
      @cars_not_rented = @cars_not_rented.where("kilometraje < ?", "#{params[:search_kilometraje]}%")
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
    @car.destroy

    respond_to do |format|
      format.html { redirect_to cars_url, notice: "Car was successfully destroyed." }
      format.json { head :no_content }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:patente, :modelo, :photo, :tanque, :kilometraje, :lat, :lng)
    end

    def esta_en_LP
      @car = Car.find(params[:id])
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
end
