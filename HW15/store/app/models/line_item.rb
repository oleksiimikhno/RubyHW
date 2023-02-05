# == Schema Information
#
# Table name: line_items
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :integer
#  order_id   :integer
#  product_id :integer
#
class LineItem < ApplicationRecord
  after_commit -> { broadcast_replace_to 'cart-total', partial: 'carts/total', locals: { total: total_line_item_quantity }, target: 'cart-total' }
  after_commit -> { broadcast_replace_to 'cart-total-price', partial: 'carts/total_price', locals: { total_price: cart_total_price }, target: 'cart-total-price' }
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def total_price
    quantity * product.price
  end

  def total_line_item_quantity
    self.cart.line_items.includes(:product).sum(&:quantity)
  end

  def cart_total_price
    self.cart.line_items.map(&:total_price).sum
  end
end
