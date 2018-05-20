class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.integer :user_id, null: false
      t.integer :vehicle_id, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.float :distance

      t.timestamps null: false
    end
  end
end
