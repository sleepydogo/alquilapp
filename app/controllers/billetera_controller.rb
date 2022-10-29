class BilleteraController < ApplicationController
  def mercadopago
  end
  require 'mercadopago'

  sdk = Mercadopago::SDK.new('YOUR_ACCESS_TOKEN')
  
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
