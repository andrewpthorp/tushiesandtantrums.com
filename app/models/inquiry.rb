# Public: The Inquiry model is what is created when a visitor contacts Ashley
# via the website.
#
# Instead of simply sending an email, I am storing a Inquiry and sending an
# email from that Inquiry. This allows me to add functionality later if she
# wants to have a record of contacts on the website.
class Inquiry < ActiveRecord::Base

  # Internal: Valid states for an Inquiry.
  VALID_STATUSES = %w(unread read)

  # Internal: Validate presence of specific attributes.
  validates :name, :email, :subject, :body, presence: true

  # Internal: Validates :status is a good state.
  validates :status, inclusion: { in: VALID_STATUSES }

  # Internal: Set default status.
  before_validation :set_default_status

  # Internal: Send an email after an Inquiry is created.
  after_create :send_email

  # Public: Determine if the current status of the Inquiry is unread.
  #
  # Returns a Boolean.
  def unread?
    self.status == 'unread'
  end

  # Public: Determine if the current status of the Inquiry is read.
  #
  # Returns a Boolean.
  def read?
    self.status == 'read'
  end

private

  # Internal: Set the default status on an Inquiry. If the status is blank, it
  # will be set to 'unread.' If the status is not blank, it will be left as is.
  #
  # Returns nothing.
  def set_default_status
    self[:status] = 'unread' if self[:status].blank?
  end

  # Internal: After an Inquiry is created, we send the email to notify Ashley.
  #
  # Returns nothing.
  def send_email
    InquiryMailer.inquiry_created_email(self).deliver
  end

end
