class Order < ApplicationRecord
  has_many :products, through: :line_items

  enum :status, %i[unpaid paid canceled], default: :unpaid
end
