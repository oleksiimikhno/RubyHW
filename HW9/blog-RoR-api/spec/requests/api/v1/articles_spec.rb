require 'swagger_helper'

RSpec.describe 'api/v1/articles', type: :request do
  path '/api/v1/articles/{id}/comments' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('comments article') do
      tags 'Article comments'

      response(200, 'successful') do
        let(:id) { '123' }

        consumes 'application/json'
        parameter name: :article, in: :query, schema: {
          type: :object,
          properties: {
            status: { type: :string, enum: %w[unpublished published] }
          },
          required: false
        }, description: 'Get comments with status published/unpublished'

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

  path '/api/v1/articles/{id}/published' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('published article') do
      tags 'Article comments'

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
  end

  path '/api/v1/articles/{id}/unpublished' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('unpublished article') do
      tags 'Article comments'

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
  end

  path '/api/v1/articles/{id}/add-tag' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    post('add_tag article') do
      tags 'Article add new tag'

      response(200, 'successful') do
        let(:id) { '123' }

        consumes 'application/json'
        parameter name: :article, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: ['name']
        }, description: 'If tag exist in tag collection.'

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

  path '/api/v1/articles' do
    get('list articles') do
      tags 'Articles'

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

    post('create article') do
      tags 'Articles'

      consumes 'application/json'
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          body: { type: :string },
          author_id: { type: :integer }
        },
        required: %w[title body author_id]
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

  path '/api/v1/articles/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show article') do
      tags 'Articles'

      response(200, 'successful') do
        let(:id) { '123' }

        consumes 'application/json'
        parameter name: :article, in: :query, schema: {
          type: :object,
          properties: {
            status: { type: :string, enum: %w[unpublished published] },
            last: { type: :integer }
          },
          required: false
        }, description: 'Get comments with status: published/unpublished. Get last limit comments with limit: integer'

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

    patch('update article') do
      tags 'Articles'

      response(200, 'successful') do
        let(:id) { '123' }

        consumes 'application/json'
        parameter name: :article, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            body: { type: :string },
            status: { type: :string, enum: %w[unpublished published] },
            author_id: { type: :integer }
          },
          required: false
        }

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

    put('update article') do
      tags 'Articles'

      response(200, 'successful') do
        let(:id) { '123' }

        consumes 'application/json'
        parameter name: :article, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            body: { type: :string },
            status: { type: :string, enum: %w[unpublished published] },
            author_id: { type: :integer }
          },
          required: false
        }

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

    delete('delete article') do
      tags 'Articles'

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

      response(204, 'Delete successful') do
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
  end
end
