class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy comments published unpublished add_tag]
  before_action :set_artticles, only: %i[index]

  # GET /articles
  def index
    @articles = @articles.filter_by_status(params[:status]) if params[:status].present?
    @articles = @articles.filter_by_phrase(params[:search]) if params[:search].present?
    @articles = Tag.filter_articles_by_tags(params[:tags]) if params[:tags].present?
    @articles = Author.filter_articles_by_author_name(params[:author]) if params[:author].present?

    render json: @articles, only: %i[id title body status created_at]
  end

  # GET /articles/1 comments published/unpublished
  def show
    @comments = @article.comments
    @comments = @article.comments.filter_by_status(params[:status]) if params[:status].present?
    @comments = @comments.filter_by_last_items_limit(params[:last]) if params[:last].present?

    @tags = @article.tags

    render json: { article: @article, comments: @comments, tags: @tags }
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  # GET /articles/1/comments
  def comments
    @comments = @article.comments.filter_by_status(params[:filter])
    render json: { article: @article, comments: @comments }
  end

  # GET /articles/1/published
  def published
    @comments = @article.comments.published
    render json: { article: @article, comments: @comments }
  end

  # GET /articles/1/unpublished
  def unpublished
    @comments = @article.comments.unpublished
    render json: { article: @article, comments: @comments }
  end

  # POST /articles/1/add-tag
  def add_tag
    if valid_tag?
      @tag = @article.tags << Tag.select_tag(params[:name])
      render json: { article: @article, tags: @tag }, status: :accepted
    else
      render json: { alert: 'Tag alrady add or not exist in table!', tags: @article.tags }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  def set_artticles
    @articles = Article.all
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :body, :status, :author_id)
  end

  def valid_tag?
    @article.tags.all_tags_names.include?(params[:name]) && !@article.tags.map(&:name).include?(params[:name])
  end
end
