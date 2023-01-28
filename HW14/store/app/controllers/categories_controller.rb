class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.with_attached_image

    flash.now[:alert] = 'Products in category not found' unless @products.exists?
  end
end
