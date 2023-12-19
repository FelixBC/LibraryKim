class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show update destroy ]

  # GET /employees
  def index
    @employees = Employee.all

    render json: @employees
  end

  # GET /employees/1
  def show
    render json: @employee
  end

  # POST /employees
  def create
    person = Person.create!(
      identification: params[:identification],
      name: params[:name],
    # ... other person attributes
      )

    address = Address.create!(
      idCountry: params[:country],
      idProvincia: params[:province],
      idCity: params[:city],
      idSector: params[:sector],
      street: params[:street],
      person: person # associate with the person
    )

    employee = Employee.create!(
      birthDate: params[:birth_date],
      idAddress: address.id, # associate with the address
      # ... other employee attributes
      person: person # associate with the person
    )

    render json: employee, status: :created
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:birth_date, :id_address)
    end
end
