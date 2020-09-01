class User < ApplicationRecord
  has_secure_password

  has_many :houses
  has_many :favorites, dependent: :destroy

  validates_presence_of :username, :email, :password, :password_digest, :image
  validates_uniqueness_of :email
end
