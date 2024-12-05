class ClockInSummary < ApplicationRecord
  belongs_to :user

  validates_presence_of [ :schedule_date, :user_id  ]
  validates_uniqueness_of :schedule_date, scope: :user_id

  enum :status, incomplete: 0, completed: 1
end
