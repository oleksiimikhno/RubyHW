class ApplicationController < ActionController::Base
  before_action :handle_cookies
  helper_method :current_cart, :cart_total_quantity

  private

  def handle_cookies
    cookies[:cart_id] = Cart.create.id unless cookies[:cart_id].present?
  end

  def current_cart
    Cart.find(cookies[:cart_id])
  end

  def cart_total_quantity
    current_cart.line_items.map(&:quantity).sum
  end
end
