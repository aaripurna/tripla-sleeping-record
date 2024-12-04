class User < ApplicationRecord
  has_many :follows, foreign_key: :followee_id, class_name: "Following"
  has_many :followees, foreign_key: :follower_id, class_name: "Following"

  has_many :followers, through: :follows
  has_many :followings, through:  :followees

  validates_presence_of :name
end
