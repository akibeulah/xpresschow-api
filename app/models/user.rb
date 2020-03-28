class User < ApplicationRecord
    include Rails.application.routes.url_helpers
    
    has_secure_password
    has_many :orders
    has_many :vendors, through: :orders

    validates :email, presence: true, uniqueness: true
    validates :first_name, presence: true, uniqueness: true
    validates :last_name, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone_number, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 8 },
              if: -> { new_record? || !password.nil? }

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
