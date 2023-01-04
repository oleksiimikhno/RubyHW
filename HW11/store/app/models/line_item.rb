class LineItem < ApplicationRecord
  belongs_to :cart
  # belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def total_price
    quantity * product.price
  end
end
