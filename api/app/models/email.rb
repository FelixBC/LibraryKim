class Email < ApplicationRecord
  validates :address, presence: true
  validates :address, uniqueness: true
  validates :address, format: { with: URI::MailTo::EMAIL_REGEXP }

end
