class Vendor < ApplicationRecord
    include Rails.application.routes.url_helpers
    include PgSearch::Model

    has_secure_password

    has_many :meals
    has_many :orders
    has_many :users, through: :orders

    validates :logo, presence: true
    validates :phone_number, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :vendorname, presence: true, uniqueness: true
    validates :company_name, presence: true, uniqueness: false
    validates :company_branch, presence: true
    validates :password,
              length: { minimum: 8 },
              if: -> { new_record? || !password.nil? }

    pg_search_scope :search_vendors,
        against: {
            company_name: 'A',
            company_branch: 'B',
            location: 'C',
            address: 'D'
        },
        using: {
            tsearch: { prefix: true, dictionary: :english }
        }

    def generate_password_token!
        self.reset_password_token = generate_token
        self.reset_password_sent_at = Time.now.utc
        save!
    end

    def password_token_valid?
        (self.reset_password_sent_at + 4.hours) > Time.now.utc
    end

    def reset_password!(password)
        # self.reset_password_token = nil
        # self.password = password

        update!(
            password: password,
            reset_password_token: nil
        )
    end

    private
    def generate_token
        SecureRandom.uuid
    end
end
