require 'CSV'

Meal.destroy_all
Vendor.destroy_all

CSV.foreach(Rails.root.join('./db/vendordata.csv'), headers: false) do |r|
  Vendor.create! do |m|
    m.vendorname = r[0]
    m.email = r[1]
    m.phone_number = r[2]
    m.company_name = r[3]
    m.company_branch = r[4]
    m.password = r[5]
  end
end

CSV.foreach(Rails.root.join('./db/mealdatan.csv'), headers: false) do |r|
    Meal.create! do |m|
      m.vendor_id = r[0]
      m.name = r[1]
      m.desc = r[2]
      m.price = r[3]
      m.sample_alt = r[4]
      m.discount = r[5]
      m.tag = r[6]
    end
end