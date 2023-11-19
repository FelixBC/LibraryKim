class Contact < ApplicationRecord
  belongs_to :email
  validates :name, presence: true
  validates :email_id, presence: true
  validates :email_id, uniqueness: true
  validates :email_id, format: { with: URI::MailTo::EMAIL_REGEXP }

end
