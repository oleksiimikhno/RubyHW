class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :status, :created_at

  has_one :author, serializer: AuthorSerializer

  has_many :comments, each_serializer: CommentSerializer do
    comments = object.comments
    comments = object.comments.filter_by_status(scope[:status]) if scope.present? && scope[:status].present?

    comments
  end

  has_many :comments, each_serializer: CommentSerializer, key: :comments_published do
    object.comments.published
  end

  has_many :comments, each_serializer: CommentSerializer, key: :comments_unpublished do
    object.comments.unpublished
  end
end
