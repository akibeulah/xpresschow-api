class Meal < ApplicationRecord
    include Rails.application.routes.url_helpers

    has_one_attached :sample
    belongs_to :vendor, required: true, dependent: :destroy

    validates :sample, presence: true
    validates :name, presence: true
    validates :desc, presence: true
    validates :price, presence: true
    validates :sample_alt, presence: :true
    
    def get_sample_url
        url_for(self.sample)
    end 

end
