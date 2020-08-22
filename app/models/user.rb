class User < ApplicationRecord
  has_secure_password
  
  validates_presence_of :username, :email, :password, :password_digest, :image
  validates_uniqueness_of :email
end
