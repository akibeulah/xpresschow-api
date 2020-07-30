class JobSerializer < ActiveModel::Serializer
  attributes :id, :username, :vendorname, :vendor_address, :payment_method, :paid, :delivered, :price, :address

  def username
    u = User.find(object.user_id)
    return u.first_name + " " + u.last_name
  end

  def vendorname
    u = Vendor.find(object.vendor_id)
    return u.company_name + " " + u.company_branch
  end

  def vendor_address
    u = Vendor.find(object.vendor_id)
    return u.address
  end
end
