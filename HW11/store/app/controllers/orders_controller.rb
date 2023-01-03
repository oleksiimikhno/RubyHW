class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[show switch_status]

  def index
    @orders = current_user.orders
  end

  def show
    @line_items = @order.cart.line_items
  end

  def create
    @order = Order.create(order_params)
    @order.update(user: current_user, cart: current_cart)

    @order.save

    cookies.delete(:cart_id)

    redirect_to orders_path
  end

  def new
    @order = Order.new
  end

  def switch_status
    @order.update(status: :paid)

    redirect_back fallback_location: root_path
  end

  private

  def set_order
    @order = Order.find_by(id: params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :email, :address, :payment)
  end
end
