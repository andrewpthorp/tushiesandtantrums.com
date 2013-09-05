# Public: The InquiryMailer handles sending emails for Inquiries.
class InquiryMailer < ActionMailer::Base

  # Public: The default address emails are sent from.
  default from: 'ashleyeosman+website@gmail.com'

  # Public: Send the email for an Inquiry.
  #
  # Returns a Mail::Message.
  def inquiry_email(inquiry)
    @inquiry = inquiry
    mail(to: 'ashleyeosman@gmail.com',
         subject: 'New Message from your Website')
  end

end
