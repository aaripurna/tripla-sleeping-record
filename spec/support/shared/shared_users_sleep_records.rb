RSpec.shared_context "user sleep records" do
  before do
    create(:clock_in_summary,
      user_id: user.id, sleep_start: '2024-01-01 22:00', sleep_end: '2024-01-02 06:00',
      status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-01')

    create(:clock_in_summary,
      user_id: user.id, sleep_start: '2024-01-02 22:00', sleep_end: '2024-01-03 06:00',
      status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-02')

    create(:clock_in_summary,
      user_id: user.id, sleep_start: '2024-01-03 22:00', sleep_end: '2024-01-04 06:00',
      status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-03')

    create(:clock_in_summary,
      user_id: user.id, sleep_start: '2024-01-04 22:00', sleep_end: '2024-01-05 06:00',
      status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-04')

    create(:clock_in_summary,
      user_id: user.id, sleep_start: '2024-01-05 22:00', sleep_end: '2024-01-06 06:00',
      status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-05')
  end
end
