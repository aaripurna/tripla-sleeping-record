class CreateClockIns < ActiveRecord::Migration[8.0]
  def change
    create_table :clock_ins do |t|
      t.integer :user_id, null: false
      t.datetime :event_time, null: false
      t.integer :event_type, null: false
      t.date :schedule_date, null: false

      t.timestamps
    end

    add_index :clock_ins, [ :user_id, :schedule_date, :event_type ], unique: true
  end
end
