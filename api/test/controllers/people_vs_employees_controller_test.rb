require "test_helper"

class PeopleVsEmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @people_vs_employee = people_vs_employees(:one)
  end

  test "should get index" do
    get people_vs_employees_url, as: :json
    assert_response :success
  end

  test "should create people_vs_employee" do
    assert_difference("PeopleVsEmployee.count") do
      post people_vs_employees_url, params: { people_vs_employee: { idEmpleado: @people_vs_employee.idEmpleado, idPeople: @people_vs_employee.idPeople } }, as: :json
    end

    assert_response :created
  end

  test "should show people_vs_employee" do
    get people_vs_employee_url(@people_vs_employee), as: :json
    assert_response :success
  end

  test "should update people_vs_employee" do
    patch people_vs_employee_url(@people_vs_employee), params: { people_vs_employee: { idEmpleado: @people_vs_employee.idEmpleado, idPeople: @people_vs_employee.idPeople } }, as: :json
    assert_response :success
  end

  test "should destroy people_vs_employee" do
    assert_difference("PeopleVsEmployee.count", -1) do
      delete people_vs_employee_url(@people_vs_employee), as: :json
    end

    assert_response :no_content
  end
end
