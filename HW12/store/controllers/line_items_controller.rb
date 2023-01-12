class LineItemsController < ApplicationController
  before_action :find_line_item, only: %i[create]
  before_action :set_line_item, only: %i[destroy increase_quantity decrease_quantity]

  def create
    if @line_item.present?
      @line_item.update(quantity: @line_item.quantity + 1)
    else
      @line_item = current_cart.line_items.create(product_id: params[:product_id])
    end

    redirect_back fallback_location: root_path
  end

  def update; end

  def destroy
    @line_item.destroy

    redirect_back fallback_location: root_path
  end

  def increase_quantity
    @line_item.update(quantity: @line_item.quantity + 1)

    redirect_back fallback_location: root_path
  end

  def decrease_quantity
    @line_item.update(quantity: @line_item.quantity - 1)

    redirect_back fallback_location: root_path
  end

  private

  def find_line_item
    @line_item = current_cart.line_items.find_by(product_id: params[:product_id])
  end

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end
