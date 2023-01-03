class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :handle_cookies
  helper_method :current_cart

  private

  def handle_cookies
    cookies[:cart_id] = Cart.create.id unless cookies[:cart_id].present?
  end

  def current_cart
    Cart.find(cookies[:cart_id])
  end
end
