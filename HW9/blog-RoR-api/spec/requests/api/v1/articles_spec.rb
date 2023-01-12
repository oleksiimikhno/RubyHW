require 'swagger_helper'

RSpec.describe 'api/v1/articles', type: :request do
  let(:author)  { Author.create(name: 'Peter') }
  let(:article) { Article.create(title: 'Title', body: 'Body title', author_id: author.id) }
  let(:comment) { Comment.create(body: 'Body comment', article_id: article.id, author_id: author.id) }
  let(:id)      { article.id }

  path '/api/v1/articles/{id}/comments' do
    parameter name: 'id', in: :path, type: :string, description: 'Get all comments from Article.'

    get('comments article') do
      tags 'Article comments'

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

  path '/api/v1/articles/{id}/published' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('published article') do
      tags 'Article comments'

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

  path '/api/v1/articles/{id}/unpublished' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('unpublished article') do
      tags 'Article comments'

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

  path '/api/v1/articles/{id}/add-tag' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: :name, in: :query, type: :string, required: :name, description: 'If tag exist in tag collection.'

    post('add_tag article') do
      tags 'Article add new tag'

      response(201, 'successful') do
        let(:name) { 'it' }
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
    let(:author_article) { Author.create(name: 'Peter') }
    let(:article) { Article.create(title: 'Title', body: 'Body title', author_id: author_article.id) }
    let(:tag) { Tag.create(name: '123') }

    get('list articles') do
      tags 'Articles'
      parameter(
        name: :status,
        in: :query,
        schema: {
          type: :string,
          enum: %w[unpublished published]
        },
        description: 'Get comments with status: published/unpublished.'
      )
      parameter name: :search, in: :query, type: :string, description: 'Search articles by phrase in title and description.'
      # parameter name: :tags, in: :query, type: :array, description: 'Search articles by tags (array).'
      parameter({
        name: :tags,
        in: :query,
        required: false,
        schema: {
          type: :array,
          items: {
            type: :string,
            description: 'Search articles by tags (array).'
          }
        }
      })
      parameter name: :author, in: :query, type: :string, description: 'Search articles by author.'
      parameter name: :order, in: :query, type: :string, description: 'Sort articles by order asc/desc.'

      response(200, 'successful') do
        let(:search) { 'Title' }
        let(:author) { 'Peter' }
        let(:order) { 'desc' }

        describe 'queries filters for api/v1/articles' do

          it 'Filter with phrase' do
            expect(article).to eq(Article.find_by(title: search))
          end

          it 'Filter with author' do
            expect(author_article.name).to eq(Author.find_by(name: author).name)
          end

          it 'Filter with tags' do
            article.tags << tag
            expect(article.tags.where(name: '123')).to eq(Article.first.tags)
          end
        end

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

      response(201, 'successful') do
        let(:article) { { title: 'Title2', body: 'Body title3', author_id: author_article.id } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }

          data = JSON.parse(response.body)['article']
          expect(data['title']).to eq(Article.first.title)
          expect(data['body']).to eq(Article.first.body)
        end
        run_test!
      end
    end
  end

  path '/api/v1/articles/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show article') do
      tags 'Articles'

      parameter(
        name: :status,
        in: :query,
        schema: {
          type: :string,
          enum: %w[unpublished published]
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

    patch('update article') do
      tags 'Articles'

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

      response(200, 'successful') do

        describe 'PATCH api/v1/articles{id}' do
          it 'check putch article' do
            article.update(body: 'New text')
            expect(Article.find_by(body: 'New text')).to eq(article)
          end
        end

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

      response(200, 'successful') do
        describe 'PUT api/v1/articles{id}' do
          it 'check put article' do
            article.update(body: 'New text')
            expect(Article.find_by(body: 'New text')).to eq(article)
          end
        end

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

      response(204, 'successful') do
        describe 'DELETE api/v1/articles{id}' do
          it 'delete article' do
            article.destroy
            expect(Article.count).to eq(0)
          end
        end
        run_test!
      end
    end
  end
end
