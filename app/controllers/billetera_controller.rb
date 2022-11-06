class BilleteraController < ApplicationController
  def mercadopago
    require 'mercadopago'
    sdk = Mercadopago::SDK.new('TEST-2532652832399670-110414-7036796f99ef154e08293e261abd3a4b-155190845')
    payment_data = {
      transaction_amount: 100,
      token: 'CARD_TOKEN',
      description: 'Payment description',
      payment_method_id: 'visa',
      installments: 1,
      payer: {
        email: 'test_user_123456@testuser.com'
      }
    }
    result = sdk.payment.create(payment_data)
    payment = result[:response]
    puts payment
  end
end
