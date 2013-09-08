class Product < ActiveRecord::Base
  attr_accessible :name, :description, :price, :price_in_cents, :image, :tag_list
  acts_as_taggable

  validates :description, presence: true
  validates :price_in_cents, presence: true
  validates :shipping_in_cents, presence: true
  validates :image, presence: true

  scope :random, order('RANDOM()')

  mount_uploader :image, ImageUploader
  monetize :price_in_cents, as: 'price'
  monetize :shipping_in_cents, as: 'shipping'

  # Public: Get the total, which is the :price plus the shipping.
  #
  # Returns a Number.
  def total
    price + shipping
  end
end
