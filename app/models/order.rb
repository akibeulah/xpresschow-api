class Order < ApplicationRecord
    belongs_to :user
    belongs_to :vendor

    validates :meal_id, presence: true
    
end