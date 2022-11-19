class PaymentsController < ApplicationController
  require 'json'
  require 'mercadopago'
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
      items: [
        {
          title: 'Carga de saldo',
          unit_price: @payment.precio.to_f,
          quantity: 1
        }
      ],
      back_urls: {
          success: 'http://127.0.0.1:3000/payments/',
          failure: 'http://127.0.0.1:3000/payments/', 
          pending: 'http://127.0.0.1:3000/payments/'
      },
      auto_return: "all",
      purpose: 'wallet_purchase'
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



  def make_payment
    preference = {
      "items": [
        { 
            "id": @payment.id,
            "title": "Carga de saldo",
            "currency_id": "ARS",
            "picture_url": "https://media.istockphoto.com/vectors/money-cash-icon-with-soft-shadow-vector-id657141614?k=20&m=657141614&s=170667a&w=0&h=qvGWi5yb9MlgrgzjSlgKwbKz-dPOBaNcwH8gtg3Qx7U=",
            "quantity": 1,
            "unit_price": @payment.precio
        }
      ]
    }
    response = HTTParty.get('https://api.mercadopago.com', {
      body: JSON.generate(preference),
      headers: {'access_token' => 'TEST-2532652832399670-110414-7036796f99ef154e08293e261abd3a4b-155190845'}
    })

    #if response.body.nil? || response.body.empty? 
    puts response.body
    redirect_to response.body
    #end 
  end

  def make_payment_v2
    sdk = Mercadopago::SDK.new(Rails.application.credentials.mercadopago.access_token)
    # Crea un objeto de preferencia
    preference_data = {
      items: [
        {
          title: 'Carga de saldo',
          unit_price: @payment.precio,
          quantity: 1
        }
      ],
      purpose: 'wallet_purchase'
    }
    preference_response = sdk.preference.create(preference_data)
    preference = preference_response[:response]
  
    # Este valor substituirá a la string "<%= @preference_id %>" en tu HTML
    @preference_id = preference['id']
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
