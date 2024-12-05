require "rails_helper"

RSpec.describe "Clock In Summary" do
  let(:user) { create(:user) }

  describe "#index" do
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

      travel_to Time.zone.parse("2024-01-06")
    end

    after { travel_back }

    it "returns status 200" do
      get api_v1_user_clock_in_summaries_path(user_id: user.id)
      expect(response).to have_http_status(:ok)
    end

    it "returns the summary list object" do
      get api_v1_user_clock_in_summaries_path(user_id: user.id)
      expect(response).to match_contract(ClockInSummaryListRecord)
    end
  end

  describe "#followings" do
    include_context "followings sleep records"

    before do
      travel_to Time.zone.parse("2024-01-06")
    end

    after { travel_back }

    it "returns status 200" do
      get followings_api_v1_user_clock_in_summaries_path(user_id: user.id)
      expect(response).to have_http_status(:ok)
    end

    it "returns the summary list object" do
      get followings_api_v1_user_clock_in_summaries_path(user_id: user.id)
      expect(response).to match_contract(ClockInSummaryListRecord)
    end
  end
end
