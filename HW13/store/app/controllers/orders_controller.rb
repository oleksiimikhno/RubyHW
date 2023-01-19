class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[show update]

  def index
    @orders = current_user.orders
  end

  def show
    if @order.nil?
      render template: 'layouts/404'
    else
      @line_items = @order.cart.line_items.includes(:product)
    end
  end

  def create
    @order = current_user.orders.create(cart: current_cart).update(order_params)
    cookies.delete(:cart_id)

    redirect_to orders_path
  end

  def new
    @order = Order.new
  end

  def update
    @order.paid!

    redirect_back fallback_location: root_path
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :email, :address, :payment)
  end
end