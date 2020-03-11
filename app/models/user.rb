class User < ApplicationRecord
    include Rails.application.routes.url_helpers
    
    has_secure_password

    has_one_attached :avatar

    validates :avatar, presence: true
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 8 },
              if: -> { new_record? || !password.nil? }

    def get_avatar_url
        self.avatar
    end

    def generate_password_token!
        self.reset_password_token = generate_token
        self.reset_password_sent_as = Time.now.utc
        save!
    end

    def passwod_token_valid?
        (self.reset_password_sent_At + 4.hours) > Time.now.utc
    end

    def reset_password!(password)
        self.reset_password_token = nil
        self.password = password
    end

    private
    def generate_token
        SecureRandom.uuid
    end
end
