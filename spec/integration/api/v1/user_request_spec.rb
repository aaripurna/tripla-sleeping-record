describe 'Users API' do
  path '/api/v1/users' do
    post 'Create User' do
      tags 'User'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %i[name]
      }

      response 201, 'created' do
        schema '$ref' => '#/components/schemas/user_single_record'

        let(:user) { { name: 'The Name' } }
        run_test!
      end

      response 422, 'Unprocessable Entity' do
        schema '$ref' => '#components/schemas/error_record'

          let(:user) { { name: nil } }
          run_test!
      end
    end

    get 'Fetch List Of Users' do
      tags 'User'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, example: 1
      parameter name: :limit, in: :query, type: :integer, example: 32
      let!(:user1) { create(:user, name: 'Foo Bar') }
      let!(:user2) { create(:user, name: 'Foo Bar') }
      let!(:user3) { create(:user, name: 'Foo Bar') }
      let!(:user4) { create(:user, name: 'Foo Bar') }

      response 200, 'Ok' do
        schema '$ref' => '#components/schemas/user_list_record'
        let(:page) { 2 }
        let(:limit) { 1 }
        run_test!
      end
    end
  end

  path "/api/v1/users/{id}" do
    get 'Get User Detail' do
      tags 'User'
      produces 'application/json'
      parameter name: :id, type: :integer, in: :path

      let!(:user) { create(:user) }

      response 200, 'Ok' do
        schema '$ref' => '#/components/schemas/user_single_record'

        let(:id) { user.id }
        run_test!
      end

      response 404, 'Not Found' do
        let(:id) { 4_0000 }
        run_test!
      end
    end

    put 'Update user detail' do
      tags 'User'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, type: :integer, in: :path
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %i[name]
      }

      let!(:user_data) { create(:user) }

      response 200, 'created' do
        schema '$ref' => '#/components/schemas/user_single_record'

        let(:id) { user_data.id }
        let(:user_params) { { name: 'The Name' } }
        run_test!
      end

      response 404, 'Not Found' do
        let(:id) { 4_0000 }
        let(:user_params) { { name: 'The Name' } }
        run_test!
      end

      response 422, 'Unprocessable entity' do
       schema '$ref' => '#components/schemas/error_record'

        let(:id) { user_data.id }
        let(:user_params) { { name: nil } }
        run_test!
      end
    end
  end
end
