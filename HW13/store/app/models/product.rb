# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string
#  name        :string
#  price       :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Product < ApplicationRecord
  after_commit :add_default_image, on: %i[create update]

  belongs_to :category
  has_many :line_items, dependent: :nullify
  has_one_attached :image

  validates :name, :description, :price, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def product_thumbnail
    if image.attached?
      image.variant(resize: '650x650!').processed
    else
      '/default_product.jpg'
    end
  end

  private

  def add_default_image
    unless image.attached?
      image.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images', 'default_product.jpg')),
        filename: '/default_product.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
