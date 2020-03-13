class Meal < ApplicationRecord

    has_one_attached :sample
    belongs_to :vendor, required: true

    validates :sample, presence: true
    validates :name, presence: true
    validates :vendor_id, presence: true
    validates :desc, presence: true
    validates :price, presence: true
    
    def get_sample_url
        self.sample
    end 

end
