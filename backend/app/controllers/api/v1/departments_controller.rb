class Api::V1::DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :update, :destroy]

  # GET /api/v1/departments
  def index
    @departments = Department.includes(:employees).all
    render json: @departments.as_json(include: {
      employees: { only: [:id, :name, :email, :role] }
    })
  end

  # GET /api/v1/departments/:id
  def show
    render json: @department.as_json(include: {
      employees: { only: [:id, :name, :email, :role, :phone] }
    })
  end

  # POST /api/v1/departments
  def create
    @department = Department.new(department_params)

    if @department.save
      render json: @department, status: :created
    else
      render json: { errors: @department.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/departments/:id
  def update
    if @department.update(department_params)
      render json: @department
    else
      render json: { errors: @department.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/departments/:id
  def destroy
    @department.destroy
    head :no_content
  end

  private

  def set_department
    @department = Department.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Department not found" }, status: :not_found
  end

  def department_params
    params.require(:department).permit(:name, :description)
  end
end
