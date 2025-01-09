class CreateDesks < ActiveRecord::Migration[7.2]
  def change
    create_table :desks do |t|
      t.integer :floor_number
      t.string :desk_number
      
      t.timestamps
    end
  end
end
