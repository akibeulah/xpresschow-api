class VendorSerializer < ActiveModel::Serializer
  attributes :id, :logo, :email, :phone_number, :rating, :company_name, :company_branch, :location
    has_many :meals
end
