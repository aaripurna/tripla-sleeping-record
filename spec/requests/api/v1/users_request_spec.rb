RSpec.describe "User Request", type: :request do
  let(:valid_attributes) do
    {
      name: "The Name"
    }
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  describe "POST /create" do
    context "data invalid" do
      it 'returns 422' do
        post api_v1_users_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({ "errors" => { "name" => [ "can't be blank" ] } })
      end
    end

    context 'data valid' do
      it 'returns status 201' do
        post api_v1_users_path, params: valid_attributes
        expect(response).to have_http_status(:created)
      end

      it 'returns the user object' do
        post api_v1_users_path, params: valid_attributes
        expect(response).to match_contract(UserSingleRecordContract)
      end

      it 'creates the record' do
        expect do
          post api_v1_users_path, params: valid_attributes
        end.to change(User, :count).by(1)
      end
    end
  end
end
