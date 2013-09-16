# Public: The ChargeMailer handles sending emails for Charges.
class ChargeMailer < ActionMailer::Base

  # Public: The default address emails are sent from.
  default from: 'tushiesandtantrums+website@gmail.com'

  # Public: Send the email for a Charge.
  #
  # Returns a Mail::Message.
  def charge_created_email(charge)
    @charge = charge
    mail(to: 'tushiesandtantrums@gmail.com',
         subject: 'New Order placed on your Website!') do |format|
      format.html { render layout: 'email' }
    end
  end

end
