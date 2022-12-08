class Author < ApplicationRecord
  has_many :articles
  has_many :comments

  validates_associated :articles, :comments
  validates :name, presence: true, length: { in: 2..25 }

  scope :filter_by_author_name, ->(name) { where(author: name) }
end
