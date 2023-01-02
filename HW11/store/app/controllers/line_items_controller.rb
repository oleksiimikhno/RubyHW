class LineItemsController < ApplicationController
  def create
    # debugger
    # redirect_to root_path
    # debugger
    # product = Product.find(params[:product_id])
    # current_cart.add_product(product)

    # current_cart
    # debugger
    line_item = current_cart.line_items.create(product_id: params[:product_id])
    # debugger
    
  end

  def update 

  end

  def destroy

  end
end
