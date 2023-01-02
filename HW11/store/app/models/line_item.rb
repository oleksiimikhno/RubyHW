class LineItem < ApplicationRecord
  belongs_to :cart
  # belongs_to :order_id
  belongs_to :product
end
