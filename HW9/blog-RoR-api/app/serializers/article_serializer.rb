class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :status, :created_at

  has_one :author, serializer: AuthorSerializer
  has_many :comments, each_serializer: CommentSerializer

  has_many :comments, each_serializer: CommentSerializer, key: :published_comments do
    object.comments.published
  end
end
