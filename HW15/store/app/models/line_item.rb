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
  after_commit -> { broadcast_replace_to 'cart-total', partial: 'carts/total', locals: { total: self.cart.line_items.includes(:product).sum(&:quantity) }, target: 'cart-total' }
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def total_price
    quantity * product.price
  end
end
