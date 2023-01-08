class Api::V1::ArticlesController < ApplicationController
  include Pagy::Backend
  before_action :set_article, only: %i[show update destroy comments published unpublished add_tag]
  before_action :set_articles, only: %i[index]

  # GET /articles
  def index
    @articles = @articles.where(status: params[:status]) if params[:status].present?
    @articles = @articles.filter_by_phrase(params[:search]) if params[:search].present?
    @articles = @articles.filter_by_tags(params[:tags]) if params[:tags].present?
    @articles = @articles.filter_by_author_name(params[:author]) if params[:author].present?
    @articles = @articles.sort_by_order(params[:order]) if params[:order].present?

    @pagy, @articles = pagy(@articles, items: 15)

    render json: @articles, include: [], each_serializer: ArticleSerializer
  end

  # GET /articles/1 comments published/unpublished
  def show
    render json: @article,
           include: ['author', 'comments', 'comments.author'],
           serializer: ArticleSerializer
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created, serializer: ArticleSerializer
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article, serializer: ArticleSerializer
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
    render json: @article,
           include: ['comments', 'comments.author'],
           serializer: ArticleSerializer,
           scope: { 'status': params[:status] }
  end

  # GET /articles/1/published
  def published
    render json: @article, include: ['comments_published'], serializer: ArticlePublishedCommentsSerializer
  end

  # GET /articles/1/unpublished
  def unpublished
    render json: @article, include: ['comments_unpublished'], serializer: ArticleUnpublishedCommentsSerializer
  end

  # POST articles?/1/add-tag?tag=new
  def add_tag
    @tags = @article.tags << Tag.all.where(name: params[:name])
    render json: { article: @article, tags: @tags }, status: :created
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  def set_articles
    @articles = Article.all
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :body, :status, :author_id)
  end
end
