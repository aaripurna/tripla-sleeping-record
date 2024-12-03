class UserRecordContract < Dry::Validation::Contract
  params do
    required(:id).filled(:integer)
    required(:name).filled(:string)
    required(:created_at).filled(:string)
    required(:updated_at).filled(:string)
  end

  rule(:created_at) do
    Time.zone.parse(value)
  rescue StandardError
    key.failure('has invalid format')
  end

  rule(:updated_at) do
    Time.zone.parse(value)
  rescue StandardError
    key.failure('has invalid format')
  end
end

class UserSingleRecordContract < Dry::Validation::Contract
  params do
    required(:attributes).schema(UserRecordContract.schema)
    required(:id).filled(:string)
    required(:type).filled(:string, eql?: 'user')
  end
end
