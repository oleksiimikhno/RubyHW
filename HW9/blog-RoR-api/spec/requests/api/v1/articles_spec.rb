require 'swagger_helper'

RSpec.describe 'api/v1/articles', type: :request do
  path '/api/v1/articles/{id}/comments' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:author) { Author.create(name: 'Peter') }
    let(:article) { Article.create(title: 'Title', body: 'Body title', author_id: author.id) }
    let(:id) { article.id }

    parameter(
      name: :status,
      in: :query,
      schema: {
        type: :string,
        enum: ['unpublished', 'published'],
      },
      description: 'Get comments with status: published/unpublished.'
    )

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
    let(:author) { Author.create(name: 'Peter') }
    let(:article) { Article.create(title: 'Title', body: 'Body title', author_id: author.id) }
    let(:id) { article.id }

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
    let(:author) { Author.create(name: 'Peter') }
    let(:article) { Article.create(title: 'Title', body: 'Body title', author_id: author.id) }
    let(:id) { article.id }

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
    let(:author) { Author.create(name: 'Peter') }
    let(:article) { Article.create(title: 'Title', body: 'Body title', author_id: author.id) }
    let(:id) { article.id }

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
          enum: ['unpublished', 'published'],
        },
        description: 'Get comments with status: published/unpublished.'
      )
      parameter name: :search, in: :query, type: :string, description: 'Search articles by phrase in title and description.'
      # parameter name: :tags, in: :query, type: :string, description: 'Search articles by tags (split tags with commas).'
      parameter name: :author, in: :query, type: :string, description: 'Search articles by author.'
      parameter name: :order, in: :query, type: :string, description: 'Sort articles by order asc/desc.'

      response(200, 'successful') do
        let(:search) { 'Title' }
        # let(:tags) { '123' }
        let(:author) { 'Peter' }
        let(:order) { 'desc' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        describe 'queries filters for api/v1/articles' do
          it 'Filter with phrase' do
            expect(article).to eq(Article.find_by(title: search))
          end

          it 'Filter with author' do
            expect(author_article.name).to eq(Author.find_by(name: author).name)
          end

          # it 'Filter with tags' do
          #   article.tags << tag
          #   debugger
          #   expect(article.tags.where(name: '123')).to eq(Author.find_by(name: author).name)
          # end
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
        end
        run_test!
      end
    end
  end

  path '/api/v1/articles/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:author) { Author.create(name: 'Author name') }
    let(:article) { Article.create(title: 'Title', body: 'Body title', author_id: author.id) }
    let(:id) { article.id }


    get('show article') do
      tags 'Articles'

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
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        describe 'PATCH api/v1/articles{id}' do
          it 'check putch article' do
            article.update(body: 'New text')
            expect(Article.find_by(body: 'New text')).to eq(article)
          end
          run_test!
        end
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
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        describe 'PUT api/v1/articles{id}' do
          it 'check put article' do
            article.update(body: 'New text')
            expect(Article.find_by(body: 'New text')).to eq(article)
          end
          run_test!
        end
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

          run_test!
        end
      end
    end
  end
end
