class ClockInSerializer
  include JSONAPI::Serializer

  attributes :id, :user_id, :schedule_date, :event_time, :event_type, :created_at, :updated_at
end
