class User < ApplicationRecord
  has_secure_password

  has_many :houses
  
  validates_presence_of :username, :email, :password, :password_digest, :image
  validates_uniqueness_of :email
end
