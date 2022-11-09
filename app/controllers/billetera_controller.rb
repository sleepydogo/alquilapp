class BilleteraController < ApplicationController
  
  


  ## GET /pagos/new
  #def new
  #  @pago = Pago.new
  #end
#
  ## PATCH/PUT /rents/1 or /rents/1.json
  #def update
  #  respond_to do |format|
  #    if @pago.update(pago_params)
  #      format.html { redirect_to rent_url(@pago), notice: "Pago was successfully updated." }
  #      format.json { render :show, status: :ok, location: @pago }
  #    else
  #      format.html { render :edit, status: :unprocessable_entity }
  #      format.json { render json: @pago.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
#
  #def create
  #  @pago = Pago.new(pago_params)
  #  @pago.aceptado = false
  #  @pago.request = 'request'
  #  @pago.response = 'response'
  #  respond_to do |format|
  #    if @pago.save
  #      format.html { redirect_to pago_url(@pago), notice: "Pago creado, esperando confirmacion..." }
  #      format.json { render :show, status: :created, location: @pago }
  #    else
  #      format.html { render :new, status: :unprocessable_entity }
  #      format.json { render json: @pago.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
#
  #def alquilapp_webhook
  #  res_arr = {
  #    transaction_id: params[:transaction_id],
  #    total: params[:total],
  #    payment_status: params[:payment_status],
  #  }
  #  TransactionHistory.create(res_arr)
  #end
#
  #private 
  #  def pago_params
  #    params.require(:pago).permit(:precio, :aceptado, :request, :response)
  #  end

end
