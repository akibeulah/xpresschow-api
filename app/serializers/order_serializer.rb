class OrderSerializer < ActiveModel::Serializer
  attributes :vendor_id, :user_id, :location, :payment_method, :paid, :price
    has_many :order_records
end
