class OrderSerializer < ActiveModel::Serializer
  attributes :id, :vendor_id, :user_id, :location, :payment_method, :dispatched, :delivered, :paid, :price, :order_records, :prepared
    
  def order_records
    records = []
    parent = []
    object.order_records.each do |o|
      parent.push(o.servings)
      parent.push(Meal.find(o.meal_id).name)
      parent.push(Meal.find(o.meal_id).price)

      records.push(parent)
      parent = []
    end

    return records
  end
end
