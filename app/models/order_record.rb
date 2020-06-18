class OrderRecord < ApplicationRecord
  belongs_to :order
  has_one :meal

  validates :meal_id, presence: true
  validates :order_id, presence: true
end