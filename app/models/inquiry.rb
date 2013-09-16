# Public: The Inquiry model is what is created when a visitor contacts Ashley
# via the website.
#
# Instead of simply sending an email, I am storing a Inquiry and sending an
# email from that Inquiry. This allows me to add functionality later if she
# wants to have a record of contacts on the website.
class Inquiry < ActiveRecord::Base

  # Internal: Allow mass-assignment.
  attr_accessible :body, :email, :name, :subject

  # Internal: Validate presence of :name.
  validates :name, presence: true

  # Internal: Validates presence of :email.
  validates :email, presence: true

  # Internal: Validates presence of :subject.
  validates :subject, presence: true

  # Internal: Validates presence of :body.
  validates :body, presence: true

  # Internal: Send an email after an Inquiry is created.
  after_create :send_email

private

  # Internal: After an Inquiry is created, we send the email to notify Ashley.
  #
  # Returns nothing.
  def send_email
    InquiryMailer.inquiry_created_email(self).deliver
  end

end
