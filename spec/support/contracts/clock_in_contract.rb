class ClockInRecord < Dry::Validation::Contract
  params do
    required(:id).filled(:integer)
    required(:schedule_date).filled(:string)
    required(:event_type).filled(:string)
    required(:event_time).filled(:string)
    required(:user_id).filled(:integer)
    required(:created_at).filled(:string)
    required(:updated_at).filled(:string)
  end
end

class ClockInSingleRecord < Dry::Validation::Contract
  params do
    required(:data).hash do
      required(:id).filled(:string)
      required(:type).filled(:string, eql?: "clock_in")
      required(:attributes).schema(ClockInRecord.schema)
    end
  end
end

class ClockInListRecord < Dry::Validation::Contract
  params do
    required(:data).array(:hash) do
      required(:type).filled(:string, eql?: "clock_in")
      required(:id).filled(:string)
      required(:attributes).schema(ClockInRecord.schema)
    end

    required(:meta).hash do
      required(:pagination).schema(PaginationContract.schema)
    end
    required(:links).schema(PaginationLinkContract.schema)
  end
end
