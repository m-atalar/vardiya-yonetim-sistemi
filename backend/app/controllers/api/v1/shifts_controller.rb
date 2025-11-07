class Api::V1::ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :update, :destroy]

  # GET /api/v1/shifts
  def index
    @shifts = Shift.includes(:employees, :shift_assignments).all
    render json: @shifts.as_json(include: {
      employees: { only: [:id, :name, :email, :role] },
      shift_assignments: { only: [:id, :date, :status], include: { employee: { only: [:id, :name] } } }
    })
  end

  # GET /api/v1/shifts/:id
  def show
    render json: @shift.as_json(include: {
      employees: { only: [:id, :name, :email, :role] },
      shift_assignments: { only: [:id, :date, :status], include: { employee: { only: [:id, :name] } } }
    })
  end

  # POST /api/v1/shifts
  def create
    @shift = Shift.new(shift_params)

    if @shift.save
      render json: @shift, status: :created
    else
      render json: { errors: @shift.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/shifts/:id
  def update
    if @shift.update(shift_params)
      render json: @shift
    else
      render json: { errors: @shift.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/shifts/:id
  def destroy
    @shift.destroy
    head :no_content
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Shift not found" }, status: :not_found
  end

  def shift_params
    params.require(:shift).permit(:name, :start_time, :end_time, :description)
  end
end
