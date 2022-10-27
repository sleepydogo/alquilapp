require "test_helper"

class RentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rent = rents(:one)
  end

  test "should get index" do
    get rents_url
    assert_response :success
  end

  test "should get new" do
    get new_rent_url
    assert_response :success
  end

  test "should create rent" do
    assert_difference("Rent.count") do
      post rents_url, params: { rent: { fecha: @rent.fecha, precio: @rent.precio } }
    end

    assert_redirected_to rent_url(Rent.last)
  end

  test "should show rent" do
    get rent_url(@rent)
    assert_response :success
  end

  test "should get edit" do
    get edit_rent_url(@rent)
    assert_response :success
  end

  test "should update rent" do
    patch rent_url(@rent), params: { rent: { fecha: @rent.fecha, precio: @rent.precio } }
    assert_redirected_to rent_url(@rent)
  end

  test "should destroy rent" do
    assert_difference("Rent.count", -1) do
      delete rent_url(@rent)
    end

    assert_redirected_to rents_url
  end
end
