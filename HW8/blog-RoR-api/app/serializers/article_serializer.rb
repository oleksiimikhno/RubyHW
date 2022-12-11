class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at

  has_one :author, serializer: AuthorSerializer
  has_many :comments, each_serializer: CommentSerializer
end
