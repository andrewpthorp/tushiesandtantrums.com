class Charge < ActiveRecord::Base
  attr_accessible :stripe_charge_id, :email, :name, :product_id,
                  :address_line_1, :address_line_2, :city, :state, :zip

  belongs_to :product

  validates :stripe_charge_id, presence: true
  validates :name, presence: true
  validates :product, presence: true
  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  validates :email, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
