class UserSerializer < ActiveModel::Serializer
  attributes :id, :avatar, :first_name, :middle_name, :last_name, :username, :email, :rating, :phone_number

  def avatar
    {
      avatar: self.object.get_avatar_url
    }
  end
end
