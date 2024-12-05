RSpec.shared_context "followings sleep records" do
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }
  let(:user_3) { create(:user) }

  before do
    create(:follow, follower_id: user.id, followee_id: user_2.id)
    create(:follow, follower_id: user.id, followee_id: user_3.id)

    create(:clock_in_summary,
        user_id: user_2.id, sleep_start: '2024-01-01 22:00', sleep_end: '2024-01-02 06:00',
        status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-01')

    create(:clock_in_summary,
      user_id: user_2.id, sleep_start: '2024-01-02 22:00', sleep_end: '2024-01-03 06:00',
      status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-02')

    create(:clock_in_summary,
      user_id: user_2.id, sleep_start: '2024-01-03 22:00', sleep_end: '2024-01-04 06:00',
      status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-03')

    create(:clock_in_summary,
      user_id: user_3.id, sleep_start: '2024-01-01 22:00', sleep_end: '2024-01-02 06:00',
      status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-01')

    create(:clock_in_summary,
      user_id: user_3.id, sleep_start: '2024-01-02 22:00', sleep_end: '2024-01-03 06:00',
      status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-02')

    create(:clock_in_summary,
      user_id: user_3.id, sleep_start: '2024-01-03 22:00', sleep_end: '2024-01-04 06:00',
      status: :completed, sleep_duration_minute: 480, schedule_date: '2024-01-03')
  end
end
