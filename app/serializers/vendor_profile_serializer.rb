class VendorProfileSerializer < ActiveModel::Serializer
  attributes :id, :logo, :vendorname, :email, :phone_number, :rating, :address, :company_name, :company_branch, :location, :tags, :order_records
    has_many :meals
    has_many :orders

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

  def tags
    tag = []

    object.meals.each do |m|
      unless tag.include?(m.tag)
        tag.push(m.tag)
      end
    end

    return tag
  end
end