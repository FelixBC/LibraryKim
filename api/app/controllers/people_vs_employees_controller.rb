class PeopleVsEmployeesController < ApplicationController
  before_action :set_people_vs_employee, only: %i[ show update destroy ]

  # GET /people_vs_employees
  def index
    @people_vs_employees = PeopleVsEmployee.all

    render json: @people_vs_employees
  end

  # GET /people_vs_employees/1
  def show
    render json: @people_vs_employee
  end

  # POST /people_vs_employees
  def create
    @people_vs_employee = PeopleVsEmployee.new(people_vs_employee_params)

    if @people_vs_employee.save
      render json: @people_vs_employee, status: :created, location: @people_vs_employee
    else
      render json: @people_vs_employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /people_vs_employees/1
  def update
    if @people_vs_employee.update(people_vs_employee_params)
      render json: @people_vs_employee
    else
      render json: @people_vs_employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /people_vs_employees/1
  def destroy
    @people_vs_employee.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_people_vs_employee
      @people_vs_employee = PeopleVsEmployee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def people_vs_employee_params
      params.require(:people_vs_employee).permit(:idPeople, :idEmpleado)
    end
end
