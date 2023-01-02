class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items, dependent: :destroy

  validates :name, :description, :price, presence: true
end
