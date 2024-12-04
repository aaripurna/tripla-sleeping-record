class FollowSingleRecordContract < Dry::Validation::Contract
  params do
    required(:data).hash do
      required(:id).filled(:string)
      required(:type).filled(:string, eql?: 'follow')
      required(:attributes).hash do
        required(:id).filled(:integer)
        required(:follower_id).filled(:integer)
        required(:followee_id).filled(:integer)
        required(:created_at).filled(:string)
        required(:updated_at).filled(:string)
      end
    end
  end
end
