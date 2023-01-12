# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cart < ApplicationRecord
  has_many :line_items, dependent: :nullify
  has_one :order, dependent: :nullify

  def total_price
    line_items.includes(:product).map(&:total_price).sum
  end
end
