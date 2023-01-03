class CartsController < ApplicationController
  def show

    products = current_cart.line_items.map { |item| { product: item.product, quantity: item.quantity } }
    # debugger
    # debugger
    # products = current_cart.line_items.map do |item|
    #   item.name
    # end
    # debugger

    render json: { products: products }
  end
end
