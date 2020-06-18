class VendorCollectionSerializer < ActiveModel::Serializer
  attributes :id, :company_name, :company_branch, :vendorname, :rating,  :logo
end