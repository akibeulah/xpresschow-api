class VendorSerializer < ActiveModel::Serializer
    attributes :id, :logo, :vendorname, :email, :phone_number, :company_name, :company_branch, :rating
    
    def logo
      {
        logo: self.object.get_logo_url
      }
    end
  end
  