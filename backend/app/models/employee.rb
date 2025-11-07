class Employee < ApplicationRecord
  belongs_to :department
  has_many :shift_assignments, dependent: :destroy
  has_many :shifts, through: :shift_assignments

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
  validates :role, presence: true, inclusion: { in: %w[manager employee supervisor] }
end
