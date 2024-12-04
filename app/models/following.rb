class Following < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, foreign_key: :followee_id, class_name: "User"

  validates_uniqueness_of :follower_id, scope: :followee_id
end
