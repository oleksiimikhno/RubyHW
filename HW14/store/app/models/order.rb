# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  address    :text
#  email      :string
#  name       :string
#  payment    :text
#  status     :integer          default("unpaid")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_orders_on_cart_id  (cart_id)
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user

  enum :status, %i[unpaid paid canceled], default: :unpaid
end
