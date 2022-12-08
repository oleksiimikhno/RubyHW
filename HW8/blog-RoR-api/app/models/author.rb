class Author < ApplicationRecord
  has_many :articles
  has_many :comments

  validates_associated :articles, :comments
  validates :name, presence: true, length: { in: 2..25 }

  scope :all_author_names, -> { Author.all.map(&:name) }
  scope :filter_articles_by_author_name, ->(name) { where('lower(name) LIKE ?', "%#{name.downcase}%").first.articles }
end
