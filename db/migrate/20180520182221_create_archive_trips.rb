class CreateArchiveTrips < ActiveRecord::Migration
  def change
    create_table :archive_trips do |t|
      t.string :name
      t.integer :user_id, null: false
      t.integer :vehicle_id, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.float :distance
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
