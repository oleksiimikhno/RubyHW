class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :current_cart

  private

  def current_cart
    @current_cart = Cart.create
  end
end
