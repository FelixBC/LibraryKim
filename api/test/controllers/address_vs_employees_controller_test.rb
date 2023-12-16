require "test_helper"

class AddressVsEmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @address_vs_employee = address_vs_employees(:one)
  end

  test "should get index" do
    get address_vs_employees_url, as: :json
    assert_response :success
  end

  test "should create address_vs_employee" do
    assert_difference("AddressVsEmployee.count") do
      post address_vs_employees_url, params: { address_vs_employee: { idAddress: @address_vs_employee.idAddress, idPeoplevsEmployee: @address_vs_employee.idPeoplevsEmployee } }, as: :json
    end

    assert_response :created
  end

  test "should show address_vs_employee" do
    get address_vs_employee_url(@address_vs_employee), as: :json
    assert_response :success
  end

  test "should update address_vs_employee" do
    patch address_vs_employee_url(@address_vs_employee), params: { address_vs_employee: { idAddress: @address_vs_employee.idAddress, idPeoplevsEmployee: @address_vs_employee.idPeoplevsEmployee } }, as: :json
    assert_response :success
  end

  test "should destroy address_vs_employee" do
    assert_difference("AddressVsEmployee.count", -1) do
      delete address_vs_employee_url(@address_vs_employee), as: :json
    end

    assert_response :no_content
  end
end
