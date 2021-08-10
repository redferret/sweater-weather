class BackgroundSerializer < ActiveModel::Serializer
  type :image
  attributes :id, :image
end