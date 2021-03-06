# Public: The InquiryMailer handles sending emails for Inquiries.
class InquiryMailer < ActionMailer::Base

  # Public: The default address emails are sent from.
  default from: 'no-reply@tushiesandtantrums.com'

  # Public: Send the email for an Inquiry.
  #
  # Returns a Mail::Message.
  def inquiry_created_email(inquiry)
    @inquiry = inquiry
    mail(to: 'tushiesandtantrums@gmail.com',
          subject: 'New Message from your Website',
          reply_to: @inquiry.email) do |format|
      format.html { render layout: 'email' }
    end
  end

end
