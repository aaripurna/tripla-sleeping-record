class ClockInSummaryRecord < Dry::Validation::Contract
  params do
    required(:id).filled(:integer)
    required(:user_id).filled(:integer)
    required(:schedule_date).filled(:string)
    required(:status).filled(:string)
    required(:sleep_start).maybe(:string)
    required(:sleep_end).maybe(:string)
    required(:sleep_duration_minute).maybe(:integer)
    required(:created_at).filled(:string)
    required(:updated_at).filled(:string)
  end

  rule(:status) do
    key.failure("status is invalid must be in #{ClockInSummary.statuses.keys}") if ClockInSummary.statuses.keys.exclude?(value)
  end
end

class ClockInSummaryListRecord < Dry::Validation::Contract
  params do
    required(:data).array(:hash) do
      required(:attributes).schema(ClockInSummaryRecord.schema)
      required(:id).filled(:string)
      required(:type).filled(:string, eql?: 'clock_in_summary')
    end

    required(:meta).hash do
      required(:pagination).schema(PaginationContract.schema)
    end
    required(:links).schema(PaginationLinkContract.schema)
  end
end
