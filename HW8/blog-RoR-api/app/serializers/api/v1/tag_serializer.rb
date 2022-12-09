class Api::V1::TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at
end
