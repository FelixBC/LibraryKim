class User < ApplicationRecord
  enum role: { admin: 0, client: 1 }

  validates_presence_of :role_id

  has_secure_password
end
