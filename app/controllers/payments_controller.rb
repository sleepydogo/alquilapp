require 'httparty'

class PaymentsController < ApplicationController
  require 'json'
  require 'mercadopago'
  
  skip_before_action :verify_authenticity_token
  before_action :set_payment, only: %i[ show edit update destroy ]

  # GET /payments or /payments.json
  def index
    @payments = @rents = Payment.where(user_id: current_user.id)
    if params[:search_precio] && params[:search_precio] != ""
			@payments = @payments.where("precio like ?", "#{params[:search_precio]}%")
    end
    if params[:search_estado] && params[:search_estado] != ""
			if (params[:seach_estado] == 'Aceptado') || (params[:seach_estado] == 'aceptado') then
        @payments = @payments.where("aceptado = true")
      elsif (params[:seach_estado] == 'Rechazado') || (params[:seach_estado] == 'rechazado') then
        @payments = @payments.where("aceptado = false")      
      end
    end
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
      notification_url: 'https://3e48-181-169-163-188.sa.ngrok.io/paymentNotification',
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
          success: 'https://3e48-181-169-163-188.sa.ngrok.io/payments/',
          failure: 'https://3e48-181-169-163-188.sa.ngrok.io/payments/', 
          pending: 'https://3e48-181-169-163-188.sa.ngrok.io/payments/'
      },
      auto_return: "all",
      purpose: 'wallet_purchase',
    }
    preference_response = sdk.preference.create(preference_data)
    @preference = preference_response[:response]
    @payment.request = preference_data
    @payment.response = preference_response[:response]
    @payment.id_mp = @payment.response['collector_id']
    @preference_id = @preference['id']
    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment.response['init_point'], allow_other_host: true, notice: "El pago fue creado exitosamente!" }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /payment/notification
  def receive_and_update
    @data_json = JSON.parse request.body.string
    puts JSON.pretty_generate(@data_json)
    if ((@data_json['action'] == "payment.created") || (@data_json['action'] == "payment.updated")) then
      @idPago = @data_json['data']['id']
      aux = 'https://api.mercadopago.com/v1/payments/' + @idPago + '/?access_token=APP_USR-7349775986801427-111915-13c2e770c6dc4ab73f6613f81b74ee3d-1243047107'
      puts 'GET request a --> ' + aux
      response = HTTParty.get(aux)
      @data_json2 = JSON.parse response.body
      puts JSON.pretty_generate(@data_json2)
      puts 'Estado del pago -->' + @data_json2["status"]
      # creo peticion get para recuperar el pago en el server de mp
      if (@data_json2["status"] == "approved")
        Payment.where(id_mp: @data_json2["collector_id"]).last.update(aceptado: true) 
        Payment.where(id_mp: @data_json2["collector_id"]).last.update(updated_at: DateTime.now) 
        userid = Payment.where(id_mp: @data_json2["collector_id"]).first.user_id
        saldoActualizado = User.find(userid).saldo + @data_json2['transaction_amount'] 
        puts saldoActualizado
        puts userid 
        User.find(userid).update(saldo: saldoActualizado)
        puts '================================================================'
        puts '    Actualizacion de Pago realizada con exito!   '
        puts '    El pago fue aceptado :D '
        puts '================================================================'
      elsif (@data_json2["status"] == "rejected")
        Payment.where(id_mp: @data_json2["collector_id"]).last.update(aceptado: false) 
        Payment.where(id_mp: @data_json2["collector_id"]).last.update(updated_at: DateTime.now)
        puts '================================================================'
        puts '    Actualizacion de Pago realizada con exito!   '
        puts '    El pago fue rechazado :( '
        puts '================================================================'
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
    @payment.destroypa

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
