# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
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
  after_create_commit -> { broadcast_prepend_to 'products' }
  after_destroy_commit -> { broadcast_remove_to 'products' }
  after_commit -> { broadcast_replace_to 'cart-total', partial: 'carts/total', locals: { total: line_items_quantity }, target: 'cart-total' }

  belongs_to :category
  has_many :line_items, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [320, 320]
    attachable.variant :main, resize_to_limit: [640, 640]
  end

  validates :name, :description, :price, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def line_item_quantity
    (line_items.exists?) ? self.line_items.last.quantity : 1 ;
  end

  private

  def add_default_image
    unless image.attached?
      image.attach(
        io: File.open(Rails.root.join('app/assets/images/default_product.jpg')),
        filename: 'default_product.jpg'
      )
    end
  end

  def line_items_quantity
    self.line_items.includes(:product).sum(&:quantity)
  end
end
