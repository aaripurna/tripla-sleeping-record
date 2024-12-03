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

  describe 'GET /:id' do
    let(:user) { create(:user, name: 'Foo Bar') }

    context 'data not exists' do
      it 'returns 404' do
        get api_v1_user_path(4_0000)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'data exists' do
      it 'returns 200' do
        get api_v1_user_path(user.id)
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user object' do
        get api_v1_user_path(user.id)
        expect(response).to match_contract(UserSingleRecordContract)
      end
    end
  end

  describe 'PUT #update' do
    let!(:user) { create(:user, name: 'Foo Bar') }

    context 'data not exists' do
      it 'returns 404' do
        put api_v1_user_path(2000), params: { name: 'Foo' }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'data invalid' do
      it 'returns 422' do
        put api_v1_user_path(user.id), params: { name: nil }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'data valid' do
      it 'returns 200' do
        put api_v1_user_path(user.id), params: { name: 'New Name' }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user object' do
        put api_v1_user_path(user.id), params: { name: 'New Name' }
        expect(response).to match_contract(UserSingleRecordContract)
      end

      it 'updates the record' do
        put api_v1_user_path(user.id), params: { name: 'New Name' }
        user.reload
        expect(user.name).to eq('New Name')
      end
    end
  end
end
