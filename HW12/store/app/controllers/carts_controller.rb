class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @products = current_cart.line_items.map { |item| { product: item.product, quantity: item.quantity } }
    @line_items = current_cart.line_items
  end
end
