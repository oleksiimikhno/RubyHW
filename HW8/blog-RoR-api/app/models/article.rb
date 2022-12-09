class Article < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :delete_all
  has_and_belongs_to_many :tags
  has_many :likes, as: :likeable

  # has_many :filter_by_status, -> { filter_by_status }, class_name: 'Comment'
  # has_many :filter_by_last_items_limit, -> { filter_by_last_items_limit }, class_name: 'Comment'

  enum :status, [ :published, :unpublished ], default: :unpublished

  validates :title, presence: true, length: { in: 2..20 }
  validates :body, presence: true, length: { in: 3..500 }
  validates :status, inclusion: { in: Article.statuses, message: 'Status %{value} is not a valid' }
  validates :author_id, numericality: { only_integer: true }

  scope :split_tags, ->(tags) { where(tags: { name: tags.split(',').collect { |tag| tag.strip.downcase } }) }
  scope :find_in_column, ->(phrase, column) { where("lower(#{column}) LIKE ?", "%#{phrase.downcase}%") }

  scope :filter_by_status, ->(status_name) { where(status: status_name) }
  scope :filter_by_phrase, ->(phrase) { find_in_column(phrase, :title).or(find_in_column(phrase, :body)) }
  scope :filter_by_tags, ->(tags) { joins(:tags).split_tags(tags).uniq }
  scope :filter_by_author_name, ->(name) { joins(:author).find_in_column(name, :name) }
  scope :sort_by_order, ->(order = 'asc') { order(title: order.downcase) }
end
