require "swagger_helper"

describe "Clock In API" do
  let!(:user) { create(:user) }
  let!(:local_time) { Time.zone.parse("2024-01-01 22:00") }

  path "/api/v1/users/{user_id}/clock_ins" do
    post "Create Clock In Record" do
      tags "Clock In"
      consumes "application/json"
      produces "application/json"

      parameter name: :user_id, in: :path, type: :integer, description: "User ID which the clock in will be performed for"
      parameter name: :clock_in_params, in: :body, schema: {
        type: :object,
        properties: {
          event_type: { type: :string, enum: %w[sleep_start sleep_end] }
        },
        required: [ :event_type ]
      }

      before do
        travel_to local_time
      end

      after { travel_back }

      response 201, 'Success' do
        schema "$ref" => "#/components/schemas/clock_in_single_record"
        let(:user_id) { user.id }
        let(:clock_in_params) { { event_type: :sleep_start } }

        run_test!
      end

      response 422, "Unprocessable Entity" do
        schema "$ref" => "#/components/schemas/error_record"
        let(:user_id) { user.id }
        let(:clock_in_params) { { event_type: :sleep_end } }

        run_test!
      end
    end

    get "Get all Clock In Records" do
      tags "Clock In"
      produces "application/json"
      parameter name: :user_id, in: :path, type: :integer, description: "User ID which the clock in will be performed for"
      parameter name: :page, in: :query, type: :integer, example: 1
      parameter name: :limit, in: :query, type: :integer, example: 32

      before do
        create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: "2024-01-01 22:00", schedule_date: "2024-01-01")
        create(:clock_in, user_id: user.id, event_type: :sleep_end, event_time: "2024-01-02 06:00", schedule_date: "2024-01-01")
        create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: "2024-01-02 22:00", schedule_date: "2024-01-02")
        create(:clock_in, user_id: user.id, event_type: :sleep_end, event_time: "2024-01-03 06:00", schedule_date: "2024-01-02")
        create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: "2024-01-03 22:00", schedule_date: "2024-01-03")
        create(:clock_in, user_id: user.id, event_type: :sleep_end, event_time: "2024-01-04 06:00", schedule_date: "2024-01-03")
      end

      response 200, "Success" do
        schema "$ref" => "#/components/schemas/clock_in_list_record"
        let(:user_id) { user.id }
        let(:page) { 2 }
        let(:limit) { 1 }

        run_test!
      end
    end
  end
end
