class CommentSerializer < ActiveModel::Serializer
  attributes :id, :status, :body, :created_at

  has_one :author, serializer: AuthorSerializer
end
