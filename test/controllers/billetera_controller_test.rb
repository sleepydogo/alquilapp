require "test_helper"

class BilleteraControllerTest < ActionDispatch::IntegrationTest
  test "should get mercadopago" do
    get billetera_mercadopago_url
    assert_response :success
  end
end
