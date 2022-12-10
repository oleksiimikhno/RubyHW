class Tag < ApplicationRecord
  has_and_belongs_to_many :articles

  validates :name, presence: true, uniqueness: true, length: { in: 2..10 }

  scope :all_tags_names, -> { Tag.pluck(:name) }
  scope :select_tag, ->(tag) { where(name: tag) }
end
