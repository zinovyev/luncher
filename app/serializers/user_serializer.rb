class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :lunches_admin
end
