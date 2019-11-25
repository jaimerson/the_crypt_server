class User < ApplicationRecord
  validates :username, :public_key, presence: true

  has_secure_password
end
