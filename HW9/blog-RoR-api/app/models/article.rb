class Article < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :likes, as: :likeable, dependent: :destroy

  enum :status, [ :published, :unpublished ], default: :unpublished

  validates :title, presence: true, length: { in: 2..20 }
  validates :body, presence: true, length: { in: 3..500 }
  validates :author_id, numericality: { only_integer: true }

  scope :serialize_tags, ->(tags) { where(tags: { name: tags.split(',').collect { |tag| tag.strip.downcase } }) }
  scope :find_in_column, ->(phrase, column) { where("#{column} ILIKE ?", "%#{phrase}%") }

  scope :filter_by_status, ->(status_name) { where(status: status_name) }
  scope :filter_by_phrase, ->(phrase) { find_in_column(phrase, :title).or(find_in_column(phrase, :body)) }
  scope :filter_by_tags, ->(tags) { joins(:tags).serialize_tags(tags).distinct }
  scope :filter_by_author_name, ->(name) { joins(:author).find_in_column(name, :name) }
  scope :sort_by_order, ->(order = 'asc') { order(title: order.downcase) }
end
