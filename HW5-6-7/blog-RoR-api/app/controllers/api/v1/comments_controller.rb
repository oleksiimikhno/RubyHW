class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy switch_status]
  before_action :set_comments, only: %i[index]

  # GET /comments published/unpublished
  def index
    @comments = @comments.filter_by_status(params[:status]) if params[:status].present?
    @comments = @comments.filter_by_last_items_limit(params[:last]) if params[:last].present?

    render json: @comments, only: %i[id body status article_id created_at]
  end

  # GET /comments/1
  def show
    render json: @comment, only: %i[id body status created_at]
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  # GET /comments/published
  def published
    @comments = Comment.published
    render json: @comments
  end

  # GET /comments/unpublished
  def unpublished
    @comments = Comment.unpublished
    render json: @comments
  end

  # POST /comments/1/switch?status=published
  def switch_status
    if Comment.statuses[params[:status]] && params[:status].present?
      @comment.update(status: params[:status])

      render json: @comment
    else
      render json: { message: "Not exist status: #{params[:status]}", comment: @comment }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_comments
    @comments = Comment.all
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body, :status, :article_id, :author_id)
  end
end
