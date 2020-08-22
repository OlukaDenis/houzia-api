class User < ApplicationRecord
  has_secure_password
  
  validates_presence_of :username, :email, :password_digest, :image, :age
  validates_uniqueness_of :email
end
