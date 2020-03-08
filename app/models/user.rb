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
end
