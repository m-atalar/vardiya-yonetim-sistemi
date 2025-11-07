class CreateShiftAssignments < ActiveRecord::Migration[8.1]
  def change
    create_table :shift_assignments do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :shift, null: false, foreign_key: true
      t.date :date, null: false
      t.string :status, null: false, default: "scheduled"

      t.timestamps
    end
    add_index :shift_assignments, [:employee_id, :shift_id, :date], unique: true, name: 'index_shift_assignments_unique'
  end
end
