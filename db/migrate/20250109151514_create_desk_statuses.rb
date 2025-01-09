class CreateDeskStatuses < ActiveRecord::Migration[7.2]
  def change
    create_table :desk_statuses do |t|
      t.string :status_name

      t.timestamps
    end
  end
end
