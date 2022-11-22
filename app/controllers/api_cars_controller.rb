class ApiCarsController < ApplicationController

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
      params.require(:pago).permit(:usuario_id, :fecha)
    end

end
