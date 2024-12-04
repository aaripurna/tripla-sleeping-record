RSpec.describe "Follows Request", type: :request do
  let!(:user_1) { create(:user, name: "Gus Fring") }
  let!(:user_2) { create(:user, name: "Walter White") }

  describe "#create" do
    context "data invalid" do
      context "when the user does not exists" do
        it 'returns 422' do
          post api_v1_follows_path, params: { follower_id: user_1.id, followee_id: 30_0000 }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns the error object' do
          post api_v1_follows_path, params: { follower_id: user_1.id, followee_id: 30_0000 }
          expect(response).to match_contract(ApiGenericError)
        end
      end
    end

    context "data valid" do
      it "returns status 201" do
        post api_v1_follows_path, params: { follower_id: user_1.id, followee_id: user_2.id }
        expect(response).to have_http_status(:created)
      end

      it 'returns the follow object' do
        post api_v1_follows_path, params: { follower_id: user_1.id, followee_id: user_2.id }
        expect(response).to match_contract(FollowSingleRecordContract)
      end
    end
  end
end
