class Order < ApplicationRecord
    belongs_to :user
    belongs_to :vendor, dependent: :destroy

    validates :meal_id, presence: true

    def order_dispatched!
        self.dispatched = !self.dispatched
        save!
    end

    def order_paid!
        self.paid = !self.paid
        save!
    end

    def order_delivered!
        self.delivered = !self.delivered
        save!
    end
    
end