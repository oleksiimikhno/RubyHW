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

  belongs_to :category
  has_many :line_items, dependent: :nullify
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :medium, resize_to_limit: [320, 320]
    attachable.variant :main, resize_to_limit: [640, 640]
  end

  validates :name, :description, :price, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private

  def add_default_image
    unless image.attached?
      image.attach(
        io: File.open(File.join(Rails.root,'app/assets/images/default_product.jpg')),
        filename: 'default_product.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
