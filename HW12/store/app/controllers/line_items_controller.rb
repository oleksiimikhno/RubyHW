class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i[destroy update]

  def create
    product = Product.find(params[:product_id])
    @line_item = current_cart.line_items.find_by(product: product)

    if @line_item.present?
      @line_item.update(quantity: @line_item.quantity + 1)
    else
      @line_item = current_cart.line_items.create(product: product)
    end

    redirect_back fallback_location: root_path
  end

  def update
    quantity = params[:action_item] == 'increase' ? @line_item.quantity + 1 : @line_item.quantity - 1
    @line_item.update(quantity: quantity)

    redirect_back fallback_location: root_path
  end

  def destroy
    @line_item.destroy

    redirect_back fallback_location: root_path
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end
