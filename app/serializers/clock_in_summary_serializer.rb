class ClockInSummarySerializer
  include JSONAPI::Serializer

  attributes :id, :user_id, :schedule_date, :status, :sleep_start,
             :sleep_end, :sleep_duration_minute, :created_at, :updated_at
end
