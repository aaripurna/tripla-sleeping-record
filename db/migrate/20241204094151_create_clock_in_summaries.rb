class CreateClockInSummaries < ActiveRecord::Migration[8.0]
  def change
    create_table :clock_in_summaries do |t|
      t.date :schedule_date, null: false
      t.integer :user_id, null: false
      t.integer :sleep_duration_minute
      t.datetime :sleep_start
      t.datetime :sleep_end
      t.integer :status

      t.timestamps
    end

    add_index :clock_in_summaries, [ :user_id, :schedule_date ], unique: true
  end
end
