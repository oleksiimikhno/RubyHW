class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items, dependent: :nullify

  validates :name, :description, :price, presence: true
end
