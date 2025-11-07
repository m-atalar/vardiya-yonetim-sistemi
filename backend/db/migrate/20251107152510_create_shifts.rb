class CreateShifts < ActiveRecord::Migration[8.1]
  def change
    create_table :shifts do |t|
      t.string :name, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.text :description

      t.timestamps
    end
  end
end
