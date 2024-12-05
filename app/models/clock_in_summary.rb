class ClockInSummary < ApplicationRecord
  belongs_to :user

  validates_presence_of [ :schedule_date, :user_id  ]
  validates_uniqueness_of :schedule_date, scope: :user_id

  enum :status, incomplete: 0, completed: 1

  scope :followings_of, ->(user_id) {
    joins(%Q(INNER JOIN "follows" ON "follows"."followee_id" = "clock_in_summaries"."user_id"))
      .where(%Q("follows"."follower_id" = ?), user_id)
  }
end
