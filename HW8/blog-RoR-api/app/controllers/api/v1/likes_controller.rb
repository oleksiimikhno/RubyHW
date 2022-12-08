class Api::V1::LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @like.save

    render json: { like: @like }, status: :create
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    render json: { alert: 'Destroy like!', like: @like }
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
