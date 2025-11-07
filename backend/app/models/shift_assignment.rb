class ShiftAssignment < ApplicationRecord
  belongs_to :employee
  belongs_to :shift

  validates :date, presence: true
  validates :status, presence: true, inclusion: { in: %w[scheduled completed cancelled] }
  validates :employee_id, uniqueness: { scope: [:shift_id, :date], message: "is already assigned to this shift on this date" }

  def active?
    status == "scheduled"
  end

  def completed?
    status == "completed"
  end
end
