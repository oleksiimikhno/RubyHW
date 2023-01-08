class ArticleUnpublishedCommentsSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :status, :created_at

  has_one :author, serializer: AuthorSerializer
  has_many :comments, each_serializer: CommentSerializer, key: :comments_unpublished do
    object.comments.unpublished
  end
end
