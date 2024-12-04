class Following < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, foreign_key: :followee_id, class_name: "User"

  validates_uniqueness_of :follower_id, scope: :followee_id
  validate :users_differences_validation

  def users_differences_validation
    if follower_id == followee_id
      errors.add(:follower_id, "must be differ from followee_id")
    end
  end
end
