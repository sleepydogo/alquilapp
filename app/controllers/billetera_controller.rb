class BilleteraController < ApplicationController
  
  def mercadopago
    require 'mercadopago'
    sdk = Mercadopago::SDK.new('TEST-2532652832399670-110414-7036796f99ef154e08293e261abd3a4b-155190845')

    preference_data = {
      'notification_url': 'https://webhook.site/31efe348-04cc-4524-bfc3-da639abe0b84',
      items: [
        {
          title: 'Cargar saldo',
          quantity: 1,
          currency_id: 'ARS',
          unit_price: 1500
        }],
      payer: {
        email: 'john@yourdomain.com'
      }
    }
    preference_response = sdk.preference.create(preference_data)
    @preference = preference_response[:response]
    puts @preference 
  end
  
  def crear_preferencia 
    require 'mercadopago'
    sdk = Mercadopago::SDK.new('TEST-2532652832399670-110414-7036796f99ef154e08293e261abd3a4b-155190845')


end
