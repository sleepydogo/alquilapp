class RentsController < ApplicationController
  before_action :set_rent, only: %i[ show edit update destroy ]

  # GET /rents or /rents.json
  def index
    @rents = Rent.where(user_id: current_user.id).order(created_at: :desc)
  end

  # GET /rents/1 or /rents/1.json
  def show
	@rent = Rent.find(params[:id])
	@hour = @rent.tiempo.hour - DateTime.now.hour 
	@minute= @rent.tiempo.min - DateTime.now.min
 	if (DateTime.now.day < @rent.tiempo.day)
		@hour= @hour+24
	end
	if (DateTime.now.min > @rent.tiempo.min)
		@minute= @minute+60
	end
  end

  # GET /rents/new
  def new
    @rent = Rent.new
  end

  # GET /rents/1/edit
  def edit
  end

  # POST /rents or /rents.json
  def create
	  #@funca = params[:car_id].to_i
    @rent = Rent.new(rent_params)
	  @rent.user_id = current_user.id
	  #@rent.fecha = DateTime.now
	  if (!@rent.tiempo.nil?)
	  	if (@rent.tiempo < DateTime.now)
	  		@rent.tiempo = @rent.tiempo.change(day: (@rent.tiempo.day + 1))
	  	end
	  @rent.precio = (((@rent.tiempo - DateTime.now)/60)/60) * 1000
    #@rent.tiempo_original = @rent.tiempo
	  end
    respond_to do |format|
      if @rent.save
	  @rent.car.update(alquilado: true)
	    @rent.user.update(alquilando: true)
        format.html { redirect_to rent_url(@rent), notice: "Alquiler realizado." }
        format.json { render :show, status: :created, location: @rent }
      else
        format.html { render :new, status: :unprocessable_entity } #No guarda los params => hay error
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rents/1 or /rents/1.json
  def update
    tiempo_anterior= Rent.find(params[:id]).tiempo
    tiempo = Rent.new(rent_params).tiempo
    if (tiempo < DateTime.now)
      tiempo = tiempo.change(day: (tiempo.day + 1))
    end
    if (tiempo <= tiempo_anterior)
       redirect_to rent_url(Rent.find(params[:id])), alert: "No puede alquilar por menos tiempo. Verifique su tiempo restante."
    else
      params[:rent][:tiempo] = tiempo
      respond_to do |format|
        if @rent.update(rent_params)   #terrible negreada mal programada pero bueno, no funciona si toco los params
          @rent.update(precio: (@rent.precio + ((((@rent.tiempo - tiempo_anterior)/60)/60) * 2000)))
          format.html { redirect_to rent_url(@rent), notice: "Alquiler extendido." }
          format.json { render :show, status: :ok, location: @rent }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @rent.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /rents/1 or /rents/1.json
  def destroy
    @rent.destroy

    respond_to do |format|
      format.html { redirect_to rents_url, notice: "Rent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def terminar_alquiler
	@rent = Rent.find(params[:id])
	if (DateTime.now > @rent.tiempo)
		excedente = -((((@rent.tiempo - DateTime.now)/60)/60) * 4000) #Se cobra el exceso de tiempo
		@rent.update(precio: (@rent.precio + excedente))
	end
	@rent.update(tiempo: DateTime.now)
	@rent.update(combustible_gastado: rand(@rent.car.tanque)) #Por ahora el combustible gastado es generado al azar.
	comb_gastado= (@rent.combustible_gastado * 160)
	@rent.update(precio: (@rent.precio + comb_gastado))
	@rent.update(activo: false)
	@rent.car.update(alquilado: false)
	@rent.user.update(alquilando: false, saldo: (@rent.user.saldo - @rent.precio))
	redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rent
      @rent = Rent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rent_params
      params.require(:rent).permit(:precio, :fecha, :car_id, :tiempo)
    end
end
