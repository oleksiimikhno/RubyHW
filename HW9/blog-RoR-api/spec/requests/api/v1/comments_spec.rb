require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
  path '/api/v1/comments/published' do
    get('published comment') do
      tags 'Comments'

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/comments/unpublished' do
    get('unpublished comment') do
      tags 'Comments'

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/comments/{id}/switch' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    patch('switch_status comment') do
      tags 'Comments'

      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          status: { type: :string, enum: %w[unpublished published] }
        },
        required: ['status']
      }, description: 'swith status comment published/unpublished'

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(500, 'Not valid status') do
        let(:status) { %w[unpublished published] }
        run_test!
      end
    end
  end

  path '/api/v1/comments' do
    get('list comments') do
      tags 'Comments'

      consumes 'application/json'
      parameter name: :comments, in: :query, schema: {
        type: :object,
        properties: {
          status: { type: :string, enum: %w[unpublished published] },
          last: { type: :integer }
        },
        required: false
      }, description: 'Get comments with status: published/unpublished. Get last limit comments with limit: integer'

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create comment') do
      tags 'Comments'

      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string },
          author_id: { type: :integer },
          article_id: { type: :integer }
        },
        required: %w[body author_id article_id]
      }, description: 'status key is default value = unpublished'

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/comments/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show comment') do
      tags 'Comments'

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update comment') do
      tags 'Comments'

      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string },
          status: { type: :string, enum: %w[unpublished published] },
          author_id: { type: :integer },
          articler_id: { type: :integer }
        },
        required: false
      }

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update comment') do
      tags 'Comments'

      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string },
          status: { type: :string, enum: %w[unpublished published] },
          author_id: { type: :integer },
          articler_id: { type: :integer }
        },
        required: false
      }

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete comment') do
      tags 'Comments'

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(404, 'invalid request') do
        let(:id) { '123' }
        run_test!
      end
    end
  end
end