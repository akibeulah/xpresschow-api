class User < ApplicationRecord
    include Rails.application.routes.url_helpers
    
    # bycrypt function for salting and hashing passwords    
    has_secure_password
    # User relations
    has_many :orders # One user can have many orders
    has_many :vendors, through: :orders # Users are related to the vendors they ordered from

    # Validations ensure that certain parameter are passed in before a user is created
    validates :email, presence: true, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } # Confirms that the email being passed in matches the standard email format, works with RegEx
    validates :phone_number, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 8 },
              if: -> { new_record? || !password.nil? } # Extra validations for the password being set, makes sure the password is secure

    # user methods
    # This method generates a password reset token and assigns the token to the user in the table
    # It also sets the time of creation of the token. After four hours the token will be wasted
    def generate_password_token!
        self.reset_password_token = generate_token
        self.reset_password_sent_at = Time.now.utc
        save! # saves changes
    end

    # This method check the validity if the token. In the passwords controller, the method is called after
    # confirming that the password token being used is linked the the account being recovered, this method will 
    # check to see if the token has existed for more than 4 hours. If it has then the token will be invalid.
    def password_token_valid?
        (self.reset_password_sent_at + 4.hours) > Time.now.utc
    end

    # After confirming the validity of the token, this method will use the new password to replace the already existing
    # password.
    def reset_password!(password)
        # self.reset_password_token = nil
        # self.password = password

        update!(
            password: password,
            reset_password_token: nil
        )
    end

    # Updates the users general location to display filterd content on the frontend
    def update_location!(location)
        update!(location: location)
    end

    private
    # Generates random UUID token for password recovery
    def generate_token
        SecureRandom.uuid
    end
end
