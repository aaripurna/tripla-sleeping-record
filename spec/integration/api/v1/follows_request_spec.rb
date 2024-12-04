require "swagger_helper"

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

  path '/api/v1/follows/unfollow' do
    delete 'Unfollow a user' do
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

      before do
        create(:follow, follower_id: user_1.id, followee_id: user_2.id)
      end

      response 200, 'Success' do
        let(:following) { { follower_id: user_1.id, followee_id: user_2.id } }
        run_test!
      end

      response 404, 'Not Found' do
        let(:following) { { follower_id: user_1.id, followee_id: 40_000 } }
        run_test!
      end
    end
  end
end
