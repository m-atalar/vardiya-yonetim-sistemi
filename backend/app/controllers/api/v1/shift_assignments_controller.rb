class Api::V1::ShiftAssignmentsController < ApplicationController
  before_action :set_shift_assignment, only: [:show, :update, :destroy]

  # GET /api/v1/shift_assignments
  def index
    @shift_assignments = ShiftAssignment.includes(:employee, :shift).all
    render json: @shift_assignments.as_json(include: {
      employee: { only: [:id, :name, :email, :role], include: { department: { only: [:id, :name] } } },
      shift: { only: [:id, :name, :start_time, :end_time] }
    })
  end

  # GET /api/v1/shift_assignments/:id
  def show
    render json: @shift_assignment.as_json(include: {
      employee: { only: [:id, :name, :email, :role], include: { department: { only: [:id, :name] } } },
      shift: { only: [:id, :name, :start_time, :end_time, :description] }
    })
  end

  # POST /api/v1/shift_assignments
  def create
    @shift_assignment = ShiftAssignment.new(shift_assignment_params)

    if @shift_assignment.save
      render json: @shift_assignment, status: :created
    else
      render json: { errors: @shift_assignment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/shift_assignments/:id
  def update
    if @shift_assignment.update(shift_assignment_params)
      render json: @shift_assignment
    else
      render json: { errors: @shift_assignment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/shift_assignments/:id
  def destroy
    @shift_assignment.destroy
    head :no_content
  end

  private

  def set_shift_assignment
    @shift_assignment = ShiftAssignment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Shift assignment not found" }, status: :not_found
  end

  def shift_assignment_params
    params.require(:shift_assignment).permit(:employee_id, :shift_id, :date, :status)
  end
end
