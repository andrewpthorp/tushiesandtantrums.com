class Product < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged
  acts_as_taggable

  attr_accessible :name, :description, :price, :price_in_cents, :shipping,
                  :shipping_in_cents, :image, :tag_list

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
  # opts  - Hash used to modify the results (default: {}, optional).
  #         :include_tax - Boolean whether to include tax in the total.
  #
  # Returns a Number.
  def total(opts={})
    if opts[:include_tax] ||= false
      price + tax + shipping
    else
      price + shipping
    end
  end

  # Public: Get the tax, which is only applied when selling to Tennessee.
  #
  # Returns a Number.
  def tax
    price * 0.0095
  end
end
