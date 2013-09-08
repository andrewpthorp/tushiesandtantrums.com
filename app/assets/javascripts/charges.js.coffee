class ChargesView extends Backbone.View
  el: '#charges-content'

  events:
    'submit #payment-form'    : 'submitForm'
    'change #charge_state'    : 'stateChanged'

  initialize: ->
    @$tax = @$ '.tax'
    @$total = @$ '.total'
    @$form = @$ '#payment-form'
    @$flash = @$ '.payment-errors'
    @$button = @$ '.submit-button'

  submitForm: (event) =>
    @$button.prop 'disabled', true
    Stripe.createToken @$form, (status, response) =>
      if response.error
        @$flash.text response.error.message
        @$flash.removeClass 'hide'
        @$button.prop 'disabled', false
      else
        $input = $('<input type="hidden" name="stripeToken" />').val response.id
        @$form.append $input
        @$form.get(0).submit()
    false

  stateChanged: (ev) =>
    $totalValue = @$total.find('.value')
    if $(ev.currentTarget).val() == 'TN'
      @$tax.removeClass 'hide'
      $totalValue.text $totalValue.data('withtax')
    else
      @$tax.addClass 'hide'
      $totalValue.text $totalValue.data('withouttax')

window.ChargesView = ChargesView
