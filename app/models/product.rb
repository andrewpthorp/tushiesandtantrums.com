class Product < ActiveRecord::Base
  attr_accessible :description, :price, :price_in_cents, :image

  validates :description, presence: true
  validates :price_in_cents, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
  monetize :price_in_cents, as: "price"
end
