class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  # before_action :current_cart
  helper_method :current_cart

  private


  def current_cart
    debugger
    Cart.find_or_create_by(cookies[:cart_id])
  end
  # def current_cart
  #   Cart.find_or_create_by
  # end
end
