class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]
  before_action :set_line_item, only: %i[update]

  def index
    @products = Product.all.with_attached_image
  end

  def show; end

  def create
    @product = Product.new(product_params)
    @product.save
  end

  def update
    @line_item = current_cart.line_items.create(product: @product) unless @line_item.present?

    quantity = params[:action_item] == 'increase' ? @line_item.quantity + 1 : @line_item.quantity - 1
    @line_item.update(quantity: quantity)

    respond_to do |format|
      format.html { redirect_back fallback_location: products_path }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@product) }
    end
  end

  def destroy
    @product.destroy
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      @products = Product.all
      flash.now[:alert] = 'Your product was not found'
      render 'index'
    end
  end

  def set_line_item
    @line_item = current_cart.line_items.find_by(product: @product)
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end
