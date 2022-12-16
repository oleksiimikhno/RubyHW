class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :status, :created_at

  has_one :author, serializer: AuthorSerializer

  has_many :comments, each_serializer: CommentSerializer do
    comments = object.comments

    if scope.present?
      comments = comments.filter_by_status(scope[:status]) if scope[:status].present?
      comments = comments.filter_by_last_items_limit(scope[:last]) if scope[:last].present?
    end

    comments
  end

  has_many :comments, each_serializer: CommentSerializer, key: :comments_published do
    object.comments.published
  end

  has_many :comments, each_serializer: CommentSerializer, key: :comments_unpublished do
    object.comments.unpublished
  end
end
