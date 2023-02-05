class ApplicationController < ActionController::Base
  before_action :handle_cookies
  helper_method :current_cart, :cart_total_quantity, :categories, :current_product_quantity

  private

  def handle_cookies
    cookies[:cart_id] = Cart.exists?(id: cookies[:cart_id]) ? cookies[:cart_id] : Cart.create.id
  end

  def current_cart
    Cart.find(cookies[:cart_id])
  end

  def current_product_quantity(product_id)
    current_cart.line_items.find_by(product_id: product_id) if cookies[:cart_id].present?
  end

  def cart_total_quantity
    current_cart.line_items.sum(&:quantity)
  end

  def categories
    Category.order(:title)
  end
end
