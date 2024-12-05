require "rails_helper"

RSpec.describe "Clock In API", type: :request do
  let!(:user) { create(:user) }
  let!(:local_time) { Time.zone.parse("2024-01-01 22:00") }

  describe "#create" do
    context "with invalid data" do
      it "returns 422" do
        travel_to local_time do
          post api_v1_user_clock_ins_path(user_id: user.id), params: { event_type: :sleep_end }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      it "returns error object" do
        travel_to local_time do
          post api_v1_user_clock_ins_path(user_id: user.id), params: { event_type: :sleep_end }
          expect(response).to match_contract(ApiGenericError)
        end
      end
    end

    context "with valid data" do
      it "returns 201" do
        travel_to local_time do
          post api_v1_user_clock_ins_path(user_id: user.id), params: { event_type: :sleep_start }
          expect(response).to have_http_status(:created)
        end
      end

      it "returns clock in object" do
        travel_to local_time do
          post api_v1_user_clock_ins_path(user_id: user.id), params: { event_type: :sleep_start }
          expect(response).to match_contract(ClockInSingleRecord)
        end
      end
    end
  end

  describe "#index" do
    before do
      create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: "2024-01-01 22:00", schedule_date: "2024-01-01")
      create(:clock_in, user_id: user.id, event_type: :sleep_end, event_time: "2024-01-02 06:00", schedule_date: "2024-01-01")
      create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: "2024-01-02 22:00", schedule_date: "2024-01-02")
      create(:clock_in, user_id: user.id, event_type: :sleep_end, event_time: "2024-01-03 06:00", schedule_date: "2024-01-02")
      create(:clock_in, user_id: user.id, event_type: :sleep_start, event_time: "2024-01-03 22:00", schedule_date: "2024-01-03")
      create(:clock_in, user_id: user.id, event_type: :sleep_end, event_time: "2024-01-04 06:00", schedule_date: "2024-01-03")
    end

    it "returns 200" do
      get api_v1_user_clock_ins_path(user_id: user.id)
      expect(response).to have_http_status(:ok)
    end

    it "returns the list of clock ins" do
      get api_v1_user_clock_ins_path(user_id: user.id)
      expect(response).to match_contract(ClockInListRecord)
    end
  end
end
