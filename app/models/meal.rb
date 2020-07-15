class Meal < ApplicationRecord
    include PgSearch::Model
    include Rails.application.routes.url_helpers

    # has_one :sample
    belongs_to :vendor, required: true, dependent: :destroy

    validates :sample, presence: true
    validates :name, presence: true
    validates :price, presence: true

    pg_search_scope :search_meals,
    against: { name: :A, desc: :C, tag: :B },
    using: {
        tsearch: { prefix: true, dictionary: :english }
    }
end
