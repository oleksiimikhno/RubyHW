class Cart < ApplicationRecord
  has_many :line_items, dependent: :nullify
  has_one :order, dependent: :nullify
end
