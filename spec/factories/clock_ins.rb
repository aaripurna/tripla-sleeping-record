FactoryBot.define do
  factory :clock_in do
    user
    event_time { "2024-12-04 19:03:00" }
    event_type { 1 }
    schedule_date { "2024-12-04" }
  end
end
