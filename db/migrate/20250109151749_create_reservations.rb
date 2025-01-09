class CreateReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.references :desk, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.date :reservation_date
      t.time :reservation_time_from
      t.string :reservation_time_to

      t.timestamps
    end
  end

end
