class Api::V1::ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at

end
