class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :article
  has_many :likes, as: :likeable

  enum :status, [ :published, :unpublished ], default: :unpublished

  validates :body, presence: true, length: { in: 3..500 }
  validates :status, inclusion: { in: Comment.statuses, message: 'Status %{value} is not a valid' }
  validates :author_id, :article_id, numericality: { only_integer: true }

  scope :filter_by_status, ->(filter) { where(status: filter) }
  scope :filter_by_last_items_limit, ->(limit = 10) { order(created_at: :desc).limit(limit) }
end