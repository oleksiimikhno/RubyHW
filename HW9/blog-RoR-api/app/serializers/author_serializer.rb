class AuthorSerializer < ActiveModel::Serializer
  attributes :name

  has_many :articles, each_serializer: ArticleSerializer
  has_many :comments, each_serializer: CommentSerializer
end
