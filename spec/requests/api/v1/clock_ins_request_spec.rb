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
end
