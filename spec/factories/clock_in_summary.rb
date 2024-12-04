FactoryBot.define do
  factory :clock_in_summary do
    user
    schedule_date { Time.zone.today }
  end
end
