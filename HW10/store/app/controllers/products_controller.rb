class ProductsController < ApplicationController
  # before_action :set_product, only: %i[show update destroy]
  # before_action :set_products, only: %i[index]

  def index
    @products

    render :products
  end

  def show
    @product
  end

  def create
    @product = Article.new(product_params)

    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def destroy
    @product.destroy
  end

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
