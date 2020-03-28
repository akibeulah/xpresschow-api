class Vendor < ApplicationRecord
    include Rails.application.routes.url_helpers
    
    has_secure_password

    has_one_attached :logo
    has_many :meals, dependent: :destroy
    has_many :orders
    has_many :users, through: :orders

    validates :logo, presence: true
    validates :phone_number, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :vendorname, presence: true, uniqueness: true
    validates :company_name, presence: true, uniqueness: false
    validates :company_branch, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 8 },
              if: -> { new_record? || !password.nil? }

    def get_logo_url
        url_for(self.logo)
    end

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
