class Api::V1::EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  # GET /api/v1/employees
  def index
    @employees = Employee.includes(:department, :shifts).all
    render json: @employees.as_json(include: {
      department: { only: [:id, :name] },
      shifts: { only: [:id, :name, :start_time, :end_time] }
    })
  end

  # GET /api/v1/employees/:id
  def show
    render json: @employee.as_json(include: {
      department: { only: [:id, :name, :description] },
      shifts: { only: [:id, :name, :start_time, :end_time] },
      shift_assignments: { only: [:id, :date, :status] }
    })
  end

  # POST /api/v1/employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee, status: :created
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/employees/:id
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/employees/:id
  def destroy
    @employee.destroy
    head :no_content
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Employee not found" }, status: :not_found
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :phone, :role, :department_id)
  end
end
