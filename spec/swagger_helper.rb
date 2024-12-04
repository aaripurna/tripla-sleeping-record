# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: '127.0.0.1:3000'
            }
          }
        }
      ],
      components: {
        schemas: {
          user_record: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            }
          },
          user_single_record: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: { type: :string, example: '10' },
                  type: { type: :string, example: 'user' },
                  attributes: { '$ref' => '#/components/schemas/user_record' }
                }
              }
            }
          },
          user_list_record: {
            type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :string, example: '10' },
                    type: { type: :string, example: 'user' },
                    attributes: { '$ref' => '#/components/schemas/user_record' }
                  }
                }
              },
              links: { '$ref' => '#/components/schemas/pagination_links' },
              meta: {
                type: :object,
                properties: {
                  pagination: { '$ref' => '#/components/schemas/pagination_details' }
                }
              }
            }
          },
          following_record: {
            type: :object,
            properties: {
              id: { type: :integer, example: 19 },
              follower_id: { type: :integer, example: 2 },
              followeee_id: { type: :integer, example: 8 },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            }
          },
          following_single_record: {
            type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  id: { type: :string, example: '10' },
                  type: { type: :string, example: 'user' },
                  attributes: { '$ref' => '#/components/schemas/following_record' }
                }
              }
            }
          },
          pagination_links: {
            type: :object,
            properties: {
              self: { type: :string, example: "/api/v1/path-to-resources?page=3&limit=32" },
              first: { type: :string, example: "/api/v1/path-to-resources?page=1&limit=32" },
              next: { type: :string, example: "/api/v1/path-to-resources?page=4&limit=32", nullable: true },
              prev: { type: :string, example: "/api/v1/path-to-resources?page=2&limit=32", nullable: true },
              last: { type: :string, example: "/api/v1/path-to-resources?page=6&limit=32" }
            }
          },
          pagination_details: {
            type: :object,
            properties: {
              page: { type: :integer, example: 3 },
              next: { type: :integer, nullable: true, example: 4 },
              prev: { type: :integer, nullable: true, example: 2 },
              count: { type: :integer, example: 192 },
              limit: { type: :integer, example: 32 }
            }
          },
          error_record: {
            type: :object,
            properties: {
              errors: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    source: {
                      type: :object,
                      properties: {
                        pointer: { type: :string }
                      }
                    },
                    detail: { type: :string }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
