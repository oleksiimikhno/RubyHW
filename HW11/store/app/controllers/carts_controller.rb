class CartsController < ApplicationController
  def show
    @items = current_cart.line_items

    render json: @items
  end
end
