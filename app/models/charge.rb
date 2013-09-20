# Public: This handles the integration between Stripe and the website. Whenever
# a credit card is charged with Stripe, a Charge is created.
#
# Every Charge has a :stripe_charge_id, which is the id of a Stripe::Charge.
# You can access the Stripe::Charge with the :stripe method. Other than that,
# this model handles personal and shipping information as well.
class Charge < ActiveRecord::Base

  # Internal: Valid states for a Charge.
  VALID_STATUSES = %w(ordered shipped completed)

  # Internal: Allow mass-assignment.
  attr_accessible :stripe_charge_id, :email, :name, :product_id, :status,
                  :address_line_1, :address_line_2, :city, :state, :zip

  # Internal: Only show 5 per page, by default.
  paginates_per 5

  # Public: Each Carge belongs to a Product.
  belongs_to :product

  # Internal: Validates presence of specific attributes.
  validates :stripe_charge_id, :email, :name, :product, :address_line_1,
            :address_line_2, :city, :state, :zip, presence: true

  # Internal: Validates format of email.
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  # Internal: Validates :status is a good state.
  validates :status, inclusion: { in: VALID_STATUSES }

  # Internal: Set default status.
  before_validation :set_default_status

  # Internal: Send an email after a Charge is created.
  after_create :send_email

  # Public: Order Charges by created_at ASC.
  #
  # Returns an ActiveRecord::Relation.
  scope :by_date, order('created_at ASC')

  # Public: Get all Charges with a status of 'ordered'.
  #
  # Returns an ActiveRecord::Relation.
  scope :ordered, where(status: 'ordered')

  # Public: Get all Charges with a status of 'shipped'.
  #
  # Returns an ActiveRecord::Relation.
  scope :shipped, where(status: 'shipped')

  # Public: Get all Charges with a status of 'completed'.
  #
  # Returns an ActiveRecord::Relation.
  scope :completed, where(status: 'completed')

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

  # Public: Determine if the current status of the Charge is ordered.
  #
  # Returns a Boolean.
  def ordered?
    self.status == 'ordered'
  end

  # Public: Determine if the current status of the Charge is shipped.
  #
  # Returns a Boolean.
  def shipped?
    self.status == 'shipped'
  end

  # Public: Determine if the current status of the Charge is commplete.
  #
  # Returns a Boolean.
  def completed?
    self.status == 'completed'
  end

private

  # Internal: Set the default status on a Charge. If the status is blank, it
  # will be set to 'ordered.' If the status is not blank, it will be left as is.
  #
  # Returns nothing.
  def set_default_status
    self[:status] = 'ordered' if self[:status].blank?
  end

  # Internal: After a Charge is created, we send the email to notify Ashley.
  #
  # Returns nothing.
  def send_email
    ChargeMailer.charge_created_email(self).deliver
  end
end
