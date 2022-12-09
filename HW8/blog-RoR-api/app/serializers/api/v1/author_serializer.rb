class Api::V1::AuthorSerializer < ActiveModel::Serializer
  attributes :name

  has_many :articles
  has_many :comments
end
