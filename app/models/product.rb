# Public: The Product model is what handles the store of the website.
class Product < ActiveRecord::Base

  # Internal: Extend the FriendlyId module to allow us to use friendly_id.
  extend FriendlyId

  # Internal: Slug the :name of Products using FriendlyId.
  friendly_id :name, use: :slugged

  # Internal: Allow Products to be tagged, or categorized.
  acts_as_taggable

  # Internal: Allow mass-assignment.
  attr_accessible :name, :description, :price, :price_in_cents, :shipping,
                  :shipping_in_cents, :image, :tag_list

  # Internal: Validate the presence of :description.
  validates :description, presence: true

  # Internal: Validate the presence of :price_in_cents.
  validates :price_in_cents, presence: true

  # Internal: Validate the presence of :shipping_in_cents.
  validates :shipping_in_cents, presence: true

  # Internal: Validate the presence of :image.
  validates :image, presence: true

  # Public: Get all Products in random order.
  #
  # Returns a Product::FriendlyIdActiveRecordRelation.
  scope :random, order('RANDOM()')

  # Internal: Use CarrierWave to mount the ImageUploader on :image.
  mount_uploader :image, ImageUploader

  # Internal: Use money-rails to handle monetizing the :price_in_cents.
  monetize :price_in_cents, as: 'price'

  # Internal: Use money-rails to handle monetizing the :shipping_in_cents.
  monetize :shipping_in_cents, as: 'shipping'

  # Public: Get the total, which is the :price plus the shipping.
  #
  # opts  - Hash used to modify the results (default: {}, optional).
  #         :include_tax - Boolean whether to include tax in the total.
  #
  # Returns an instance of Money.
  def total(opts={})
    if opts[:include_tax] ||= false
      price + tax + shipping
    else
      price + shipping
    end
  end

  # Public: Get the tax, which is only applied when selling to Tennessee.
  #
  # Returns an instance of Money.
  def tax
    price * 0.0095
  end
end
