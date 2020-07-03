class UserSerializer < ActiveModel::Serializer 
  # This class extends ActiveModel::Serializer, which tells rails that is a serialzer. Serializers are used to 
  # return selected data upon a request. By default, whe a request is made for a model, only the columns of that model are
  # returned. With serializers, we can decide whic column entries (attributes) to return. We can also decide to send out 
  # relations.

  attributes :id, :first_name, :last_name, :email, :phone_number, :orders, :order_records, :last_order
    has_many :orders # This line will simply return all the orders for the specified user.
  # The attributes list returns data that can be found ONLY in the table of the model specified and fake attributes
  # generated within the serializer, such as: last_order and order_records.

  # This method returns the last order of the specified user. The user is specified at the call of the serializer. It is not
  # explicitly passed in like a normal method.
  def last_order
    return object.orders.last
    # object here refers to the specific entity being passed in (in this case a user). With object, we can fetch the entities relations.
    # Here we are fetching the last order made by the user.
  end

  # This method returns the specifics/content of each order. Because the content of each order is not represented in the orders table, this method 
  # uses the model's relations to retrieve the order contents that are related to the order model as order record.
  def order_records
    orders = [] # variable orders created as an array
    parent = [] # varaible parent created as an array
    object.orders.each do |o| # gets all objects orders and iterates(a) through them. 
      o.order_records.each do |m|  # gets all the order's records and iterates(b) through them
        parent.push(Meal.find(m.meal_id)) # pushes the order records from (b) into the parent array
      end
      parent.push(o.vendor.company_name + ", " + o.vendor.company_branch) 
      # I decided that when all the order records are pushed into the parent array, I will push the vendor along with it for easy identification of 
      # which vendor processed the order.
      orders.push(parent) # After all this, the paret array is pushed into the orders array. This makes orders an array of arrays.
      parent = [] # Parent is them emptied in preparation for the next iteration (a).
    end
    
    return orders # returns the orders array of arrays
  end
end
