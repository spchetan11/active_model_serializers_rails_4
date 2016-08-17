class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_number, :quantity
end
