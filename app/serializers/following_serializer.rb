class FollowingSerializer
  include JSONAPI::Serializer

  attributes :id, :follower_id, :followee_id, :created_at, :updated_at
end
