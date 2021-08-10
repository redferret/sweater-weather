class UserSerializer < ActiveModel::Serializer
  type :users
  attributes :email, :api_key
end
