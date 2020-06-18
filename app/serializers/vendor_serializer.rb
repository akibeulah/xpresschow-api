class VendorSerializer < ActiveModel::Serializer
  attributes :id, :logo, :vendorname, :email, :phone_number, :rating, :company_name, :company_branch, :location, :tags
    has_many :meals

  def tags
    tag = []

    object.meals.each do |m|
      unless tag.include?(m.tag)
        tag.push(m.tag)
      end
    end

    return tag
  end
end
