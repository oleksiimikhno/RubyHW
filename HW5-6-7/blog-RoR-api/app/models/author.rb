class Author < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates_associated :articles, :comments
  validates :name, presence: true, length: { in: 2..20 }
end
