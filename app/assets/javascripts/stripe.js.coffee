class StripeIntegration extends Backbone.View
  el: '#payment-form'

  events:
    'submit' : 'submitForm'

  initialize: ->
    @$flash = @$('.payment-errors')
    @$button = @$('.submit-button')

  submitForm: (event) =>
    @$button.prop 'disabled', true
    Stripe.createToken @$el, (status, response) =>
      if response.error
        @$flash.text(response.error.message).show()
        @$button.prop 'disabled', false
      else
        token = response.id
        @$el.append($('<input type="hidden" name="stripeToken" />').val(token))
        @$el.get(0).submit()
    false

window.StripeIntegration = StripeIntegration
