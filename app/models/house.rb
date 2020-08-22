class House < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates_presence_of :name, :description, :image, :price
end
