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
        @$flash.text response.error.message
        @$flash.removeClass 'hide'
        @$button.prop 'disabled', false
      else
        $input = $('<input type="hidden" name="stripeToken" />').val response.id
        @$el.append $input
        @$el.get(0).submit()
    false

window.StripeIntegration = StripeIntegration
