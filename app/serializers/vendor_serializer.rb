class VendorSerializer < ActiveModel::Serializer
    attributes :id, :logo, :vendorname, :email
  
    def logo
      {
        logo: self.object.get_logo_url
      }
    end
  end
  