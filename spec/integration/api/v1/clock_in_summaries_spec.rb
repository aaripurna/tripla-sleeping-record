require "swagger_helper"

describe "Sleeping Record API" do
  path "/api/v1/users/{user_id}/clock_in_summaries" do
    get "Get current user's sleeping record" do
      tags "Sleeping Record"
      produces "application/json"
      parameter name: :user_id, in: :path, type: :integer, description: "User ID which the clock in will be performed for"
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :limit, in: :query, type: :integer, required: false
      parameter name: :start_date, in: :query, required: false, schema: {
        type: :string, format: "date", description: "optional, the default value will be from 1 week ago"
      }
      parameter name: :end_date, in: :query, required: false, schema: {
        type: :string, format: "date", description: "optional, the default value will be the current date"
      }

      let(:user) { create(:user) }

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

      response 200, "Success" do
        schema "$ref" => "#/components/schemas/summary_clock_in_list_record"
        let(:user_id) { user.id }
        run_test!
      end
    end
  end
end
