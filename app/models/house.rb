class House < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :description, :image, :price
end