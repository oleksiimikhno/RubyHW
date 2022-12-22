class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all

    render :products
  end

  def show; end

  def create
    @product = Article.new(product_params)

    if @product.save
      redirect_to @product, notice: "High score was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def destroy
    @product.destroy
  end

  private

  def set_product
    @product = Product.find[params[:id]]
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end
