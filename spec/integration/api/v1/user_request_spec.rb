require 'swagger_helper'

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
        schema type: :object,
          properties: {
            id: { type: :string, example: '1' },
            type: { type: :string, example: 'user' },
            attributes: {
              type: :object,
              properties: {
                id: { type: :integer, example: 10 },
                name: { type: :string, example: 'Samson' },
                created_at: { type: :string, format: 'date-time' },
                updated_at: { type: :string, format: 'date-time' }
              }
            }
          }

        let(:user) { { name: 'The Name' } }
        run_test!
      end

      response 422, 'Unprocessable Entity' do
        schema type: :object,
          properties: {
            errors: {
              type: :object,
              properties: {
                name: {
                  type: :array,
                  item: { type: :string }
                }
              }
            }
          }

          let(:user) { { name: nil } }
          run_test!
      end
    end
  end
end
