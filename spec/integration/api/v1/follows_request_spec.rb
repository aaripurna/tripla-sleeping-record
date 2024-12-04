describe 'Follows API' do
  let!(:user_1) { create(:user, name: "Gus Fring") }
  let!(:user_2) { create(:user, name: "Walter White") }

  path '/api/v1/follows' do
    post 'Create Follow' do
      tags 'Following'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :following, in: :body, schema: {
        type: :object,
        properties: {
          follower_id: { type: :integer, example: 10 },
          followee_id: { type: :integer, example: 45 }
        }
      }

      response 201, 'Created' do
        schema '$ref' => '#/components/schemas/following_single_record'
        let(:following) do
          {
            follower_id: user_1.id,
            followee_id: user_2.id
          }
        end

        run_test!
      end

      response 422, 'Unprocessable entity' do
        schema '$ref' => '#components/schemas/error_record'
        let(:following) do
          {
            follower_id: nil,
            followee_id: user_2.id
          }
        end

        run_test!
      end
    end
  end
end
