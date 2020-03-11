class UserSerializer < ActiveModel::Serializer
    attributes :id, :logo, :first_name, :middle_name, :last_name, :username, :email
  
    def logo
      {
        logo: self.object.get_logo_url
      }
    end
  end
  