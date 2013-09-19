# Public: All helpers that are to be used for Charges are in here. Even though
# all helpers are application-wide, it makes sense to put them here for clarity.
module ChargesHelper

  # Public: Get the status updates for a given Charge. If the Charge has simply
  # been ordered, it will only have that status. If the Charge has been shipped,
  # it will have the ordered and shipped status. If the Charge has been
  # completed, it will have the ordered and completed status.
  #
  # charge - The Charge to get status updates for.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def charge_status(charge)
    statuses = [
      "<span>Ordered:</span> #{charge.created_at.localtime.to_s(:pretty)}"
    ]

    if charge.shipped?
      statuses << "<span>Shipped:</span> #{charge.updated_at.localtime.to_s(:pretty)}"
    elsif charge.completed?
      statuses << "<span>Completed:</span> #{charge.updated_at.localtime.to_s(:pretty)}"
    end

    content_tag(:ul, class: 'charge-statuses') do
      statuses.map do |status|
        concat(content_tag(:li, raw(status)))
      end
    end
  end

  # Public: Get the URL for a charge to view on stripe.com.
  #
  # charge - The Charge to get a link for.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def charge_stripe_link(charge)
    return nil if charge.stripe_charge_id.blank?

    link_to 'View this on Stripe',
            "https://manage.stripe.com/payments/#{charge.stripe_charge_id}",
            target: '_blank', class: 'action-button square stripe-link'
  end

end
