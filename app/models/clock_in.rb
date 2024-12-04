class ClockIn < ApplicationRecord
  belongs_to :user
  validates_presence_of [ :event_time, :event_type, :schedule_date ]

  validates_uniqueness_of :user_id, scope: [ :event_type, :schedule_date ]

  enum :event_type, %i[sleep_start sleep_end]
end
