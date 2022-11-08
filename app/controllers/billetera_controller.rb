class BilleteraController < ApplicationController
  
  def vista  
  end

  def pago
    @pago = Pago.new(pago_params)

    respond_to do |format|
      if @pago.save
        format.html { redirect_to pago_url(@pago), notice: "Pago creado, esperando confirmacion..." }
        format.json { render :show, status: :created, location: @pago }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pago.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # Post /billetera/pago
  def update_pago 
    @pago = Pago.find(params[:id])
    if @pago.update_attributes(pago_params)
      redirect_to pagos_url
    else  
      render action: 'pagar'
    end
  end

  def alquilapp_webhook
    res_arr = {
      transaction_id: params[:transaction_id],
      total: params[:total],
      payment_status: params[:payment_status],
    }
    TransactionHistory.create(res_arr)
  end

  private 
    def pago_params
      params.require(:pago).permit(:usuario_id, :precio, :aceptado, :request, :response, :fecha)
    end

end
