class LineItem < ApplicationRecord
  belongs_to :cart_id
  belongs_to :order_id
  belongs_to :product_id
end
