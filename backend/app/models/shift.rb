class Shift < ApplicationRecord
  has_many :shift_assignments, dependent: :destroy
  has_many :employees, through: :shift_assignments

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
