# Public: This handles the integration between Stripe and the website. Whenever
# a credit card is charged with Stripe, a Charge is created.
#
# Every Charge has a :stripe_charge_id, which is the id of a Stripe::Charge.
# You can access the Stripe::Charge with the :stripe method. Other than that,
# this model handles personal and shipping information as well.
class Charge < ActiveRecord::Base

  # Internal: Allow mass-assignment.
  attr_accessible :stripe_charge_id, :email, :name, :product_id,
                  :address_line_1, :address_line_2, :city, :state, :zip

  # Public: Each Carge belongs to a Product.
  belongs_to :product

  # Internal: Validates presence of :stripe_charge_id.
  validates :stripe_charge_id, presence: true

  # Internal: Validates presence of :name.
  validates :name, presence: true

  # Internal: Validates presence of :product.
  validates :product, presence: true

  # Internal: Validates presence of :address_line_1.
  validates :address_line_1, presence: true

  # Internal: Validates presence of :city.
  validates :city, presence: true

  # Internal: Validates presence of :state.
  validates :state, presence: true

  # Internal: Validates presence of :zip.
  validates :zip, presence: true

  # Internal: Validates presence of :email.
  validates :email, presence: true

  # Internal: Validates format of email.
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  # Public: Get the Stripe::Charge object from Stripe's API.
  #
  # Returns a Stripe::Charge.
  def stripe
    @stripe ||= Stripe::Charge.retrieve(self.stripe_charge_id)
  end

  # Public: Validates the Charge except for Stripe integration.
  #
  # Returns a Boolean.
  def valid_without_stripe?
    self.valid?
    self.errors.delete(:stripe_charge_id)
    return !self.errors.any?
  end
end
