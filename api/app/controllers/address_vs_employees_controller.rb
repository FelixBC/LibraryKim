class AddressVsEmployeesController < ApplicationController
  before_action :set_address_vs_employee, only: %i[ show update destroy ]

  # GET /address_vs_employees
  def index
    @address_vs_employees = AddressVsEmployee.all

    render json: @address_vs_employees
  end

  # GET /address_vs_employees/1
  def show
    render json: @address_vs_employee
  end

  # POST /address_vs_employees
  def create
    @address_vs_employee = AddressVsEmployee.new(address_vs_employee_params)

    if @address_vs_employee.save
      render json: @address_vs_employee, status: :created, location: @address_vs_employee
    else
      render json: @address_vs_employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /address_vs_employees/1
  def update
    if @address_vs_employee.update(address_vs_employee_params)
      render json: @address_vs_employee
    else
      render json: @address_vs_employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /address_vs_employees/1
  def destroy
    @address_vs_employee.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address_vs_employee
      @address_vs_employee = AddressVsEmployee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_vs_employee_params
      params.require(:address_vs_employee).permit(:idPeoplevsEmployee, :idAddress)
    end
end
