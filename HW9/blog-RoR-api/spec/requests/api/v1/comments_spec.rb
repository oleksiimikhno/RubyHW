require 'swagger_helper'
require 'rails_helper'

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

  path '/api/v1/comments' do
    let(:author) { Author.create(name: 'Author name') }
    let(:article) { Article.create(title: 'Title', body: 'Body title', author_id: author.id) }

    get('list comments') do
      tags 'Comments'

      parameter(
        name: :status,
        in: :query,
        schema: {
          type: :string,
          enum: ['unpublished', 'published'],
        },
        description: 'Get comments with status: published/unpublished.'
      )
      parameter name: :last, in: :query, type: :integer, description: 'Get last limit comments with limit: integer.'

      response(200, 'successful') do
        let(:last) { '10' }

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

      response(201, 'successful') do
        let(:comment) { { body: 'Body comment', article_id: article.id, author_id: author.id } }

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
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:author) { Author.create(name: 'Author name') }
    let(:article) { Article.create(title: 'Title', body: 'Body title', author_id: author.id) }
    let(:comment) { Comment.create(body: 'Body comment', article_id: article.id, author_id: author.id) }
    let(:id) { comment.id }

    get('show comment') do
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
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        describe 'PATCH api/v1/comments{id}' do
          it 'check putch comment' do
            comment.update(body: 'New text')
            expect(Comment.find_by(body: 'New text')).to eq(comment)
          end
          run_test!
        end
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
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        describe 'PUT api/v1/comments{id}' do
          it 'check put comment' do
            comment.update(body: 'New text')
            expect(Comment.find_by(body: 'New text')).to eq(comment)
          end
          run_test!
        end
      end
    end

    delete('delete comment') do
      tags 'Comments'

      response(204, 'successful') do
        describe 'DELETE api/v1/comments{id}' do
          it 'delete comment' do
            comment.destroy
            expect(Comment.count).to eq(0)
          end

          run_test!
        end
      end
    end
  end
end
