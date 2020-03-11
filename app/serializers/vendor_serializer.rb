class UserSerializer < ActiveModel::Serializer
    attributes :id, :logo, :first_name, :middle_name, :last_name, :username, :email, :phone_number, :company_name, :company_branch, :rating
  
    def logo
      {
        logo: self.object.get_logo_url
      }
    end
  end
  