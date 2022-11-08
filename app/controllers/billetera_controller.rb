class BilleteraController < ApplicationController
  
  def vista  
  end

  def create_pago
    @pago = Pago.new()
  end
  
  # GET /billetera/pago
  def pago 
    render 'billetera/_saldo-editer'
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
