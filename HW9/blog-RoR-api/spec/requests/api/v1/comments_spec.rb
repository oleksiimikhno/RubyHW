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
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:new_comment) { Comment.new(body: 'Body comment', article_id: 1, author_id: 1) }
    let(:update_comment) { Comment.update(body: 'Body comment', article_id: 1, author_id: 1) }

    get('show comment') do
      tags 'Comments'

      response(200, 'successful') do
        let(:id) { new_comment.id }

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

      # response(200, 'successful') do
      #   let(:comment) { update_comment }

      #   after do |example|
      #     example.metadata[:response][:content] = {
      #       'application/json' => {
      #         example: JSON.parse(response.body, symbolize_names: true)
      #       }
      #     }
      #   end
      #   run_test!
      # end
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

      # response(200, 'successful') do
      #     let(:author) { Author.create(name: 'Faker::Name.name') }
      #   let(:article) { Article.create(title: 'Faker::Movie.title', body: 'Faker::Movie.quote', author_id: author.id) }
      #   let(:comment) { Comment.create(body: body, author_id: author.id, article_id: article.id) }
      #   let(:id) { comment.id }

      #   let(:comment) { Comment.update(body: body, author_id: author.id, article_id: article.id) }

      #   after do |example|
      #     debugger
      #     example.metadata[:response][:content] = {
      #       'application/json' => {
      #         example: JSON.parse(response.body, symbolize_names: true)
      #       }
      #     }
      #   end
      #   run_test!
      # end
    end

    delete('delete comment') do
      tags 'Comments'
      

      response(200, 'successful') do


        # let(:author) { Author.create(name: 'Faker::Name.name') }
        # let(:article) { Article.create(title: 'Faker::Movie.title', body: 'Faker::Movie.quote', author_id: author.id) }
        # let(:comment) { Comment.create(body: body, author_id: author.id, article_id: article.id) }
        # let(:id) { comment.id }

        # let!(:comment) { Comment.create(body: 'Body comment', article_id: 1, author_id: 1).id }
        
        # it 'dekete a comment' do
        #   expect {
        #     delete "api/v1/comments/#{comment.id}"
        #   }.to change { Comment.count }.from(1).to(0)
        # end


        # after do |example|
        #   example.metadata[:response][:content] = {
        #     'application/json' => {
        #       example: JSON.parse(response.body, symbolize_names: true)
        #     }
        #   }
        # end
        # run_test!
      end
    end
  end
end
