class User < ApplicationRecord
  validates :username, :public_key, presence: true
  validates :username, uniqueness: true

  has_secure_password
end
