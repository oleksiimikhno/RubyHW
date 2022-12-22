class ProductsController < ApplicationController
  # before_action :set_product, only: %i[show update destroy]
  # before_action :set_products, only: %i[index]

  private

  def set_product
    @product = Product.find[params[:id]]
  end

  def set_products
    @products = Product.all
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end
