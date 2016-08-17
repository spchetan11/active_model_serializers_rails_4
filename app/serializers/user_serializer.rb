class UserSerializer < ActiveModel::Serializer
  has_many :orders#, root: :orders_attributes

  attributes :id, :name, :email, :age, :company
end
