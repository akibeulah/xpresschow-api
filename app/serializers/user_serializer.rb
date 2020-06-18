class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone_number, :orders, :order_records, :last_order
    has_many :orders

    def last_order
      return object.orders.last
    end

    def order_records
      orders = []
      parent = []
      object.orders.each do |o|
        o.order_records.each do |m|
          parent.push(Meal.find(m.meal_id))
        end
        parent.push(o.vendor.company_name + ", " + o.vendor.company_branch)
        orders.push(parent)
        parent = []
      end
      
      return orders
    end
end
