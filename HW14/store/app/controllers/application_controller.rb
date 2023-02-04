class ApplicationController < ActionController::Base
  before_action :handle_cookies
  helper_method :current_cart, :cart_total_quantity, :categories

  private

  def handle_cookies
    cookies[:cart_id] = Cart.exists?(id: cookies[:cart_id]) ? cookies[:cart_id] : Cart.create.id
  end

  def current_cart
    Cart.find(cookies[:cart_id])
  end

  def cart_total_quantity
    current_cart.line_items.includes(:product).sum(&:quantity)
  end

  def categories
    Category.order(:title)
  end
end
