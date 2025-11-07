class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :role, null: false, default: "employee"
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
    add_index :employees, :email, unique: true
  end
end
