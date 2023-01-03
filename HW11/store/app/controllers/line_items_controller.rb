class LineItemsController < ApplicationController
  before_action :find_line_item, only: %i[create]

  def create
    # debugger
    # redirect_to root_path
    # debugger
    # product = Product.find(params[:product_id])
    # current_cart.add_product(product)

    # current_cart
    # debugger
    # debugger
    if @line_item.present?
      @line_item.update(quantity: @line_item.quantity + 1)
    else
      @line_item = current_cart.line_items.create(product_id: params[:product_id])
    end
    
    # debugger
    
  end

  def update 

  end

  def destroy

  end

  private

  def find_line_item
    @line_item = current_cart.line_items.find_by(product_id: params[:product_id])
  end
end
