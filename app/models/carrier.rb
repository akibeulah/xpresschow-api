class Carrier < ApplicationRecord
  has_secure_password

  has_many :deliveries
  has_many :orders, through: :deliveries

  validates :carriername, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } # Confirms that the email being passed in matches the standard email format, works with RegEx
  validates :phone_number, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || !password.nil? } # Extra validations for the password being set, makes sure the password is secure
end