class MealSerializer < ActiveModel::Serializer
    attributes :id, :sample, :name, :price, :desc, :rating
    
    def sample
      {
        sample: self.object.get_sample_url
      }
    end
end