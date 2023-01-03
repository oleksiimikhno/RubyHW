class Cart < ApplicationRecord
  has_many :line_items, dependent: :nullify
  has_one :order, dependent: :nullify

  def total_price
    self.line_items.map(&:total_price).sum
  end
end
