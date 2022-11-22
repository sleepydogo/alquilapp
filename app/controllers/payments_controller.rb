class PaymentsController < ApplicationController
  require 'json'
  require 'mercadopago'
  require 'net/http'
  
  skip_before_action :verify_authenticity_token
  before_action :set_payment, only: %i[ show edit update destroy ]

  # GET /payments or /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.user_id = current_user.id
    sdk = Mercadopago::SDK.new('APP_USR-7349775986801427-111915-13c2e770c6dc4ab73f6613f81b74ee3d-1243047107')
    # Crea un objeto de preferencia
    preference_data = {
      notification_url: 'https://84b1-181-169-163-188.sa.ngrok.io/payment-notification',
      items: [
        {
          currency_id: "ARS",
          picture_url: "https://i.ibb.co/HTxfHyn/Logo-3.png",
          title: 'Carga de saldo - Alquilapp',
          unit_price: @payment.precio.to_i,
          quantity: 1,
        }
      ],
      back_urls: {
          success: 'https://84b1-181-169-163-188.sa.ngrok.io/payments/',
          failure: 'https://84b1-181-169-163-188.sa.ngrok.io/payments/', 
          pending: 'https://84b1-181-169-163-188.sa.ngrok.io/payments/'
      },
      auto_return: "all",
      purpose: 'wallet_purchase',
      metadata: {
        id_pago_interno: @payment.id
      }
    }
    preference_response = sdk.preference.create(preference_data)
    @preference = preference_response[:response]
    @payment.request = preference_data
    @payment.response = preference_response[:response]
    # Este valor substituirá a la string "<%= @preference_id %>" en tu HTML
    @preference_id = @preference['id']
    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment.response['init_point'], allow_other_host: true, notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /payment/notification
  def receive_and_update
    data_json = JSON.parse request.body.read
    
    @idPago = data_json['data']['id']
    
    aux = 'https://api.mercadopago.com/v1/payments/' + @idPago 
    uri = URI(aux)
    req = Net::HTTP::Get.new(uri)
    # access token
    req['Authorization'] = 'Bearer APP_USR-7349775986801427-111915-13c2e770c6dc4ab73f6613f81b74ee3d-1243047107'
    req_options = {
      use_ssl: uri.scheme == "https"
    }
    res = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(req) 
      data_finder = res.body.inspect
      data_json = JSON.parse res.body
      # creo peticion get para recuperar el pago en el server de mp
      if (data_finder["approved"])
        id = data_json["metadata"]["id_pago_interno"]
        puts id
        Payment.find(id).update(aceptado: true) 
        userid = Payment.find(id).user_id
        saldoActualizado = User.find(userid).saldo + data_json['transaction_amount'] 
        User.find(userid).update(saldo: saldoActualizado)
      end
    end
  end


  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:id, :precio, :aceptado, :request, :response)
    end
end
