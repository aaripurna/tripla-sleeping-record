class UserSerializer
  include JSONAPI::Serializer
  set_id :id
  set_type :user

  attributes :id, :name, :created_at, :updated_at
end
