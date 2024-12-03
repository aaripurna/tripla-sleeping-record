class UserSerializer < ApplicationSerializer
  type "user"

  attributes :id, :name, :created_at, :updated_at
end
