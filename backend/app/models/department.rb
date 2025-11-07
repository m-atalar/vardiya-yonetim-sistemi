class Department < ApplicationRecord
  has_many :employees, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
