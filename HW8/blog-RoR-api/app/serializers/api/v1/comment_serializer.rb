class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :status, :body, :created_at


end
