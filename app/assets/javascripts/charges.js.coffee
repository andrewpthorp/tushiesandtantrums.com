$ ->

  stripeResponseHandler = (status, response) ->
    $form = $ '#payment-form'
    if response.error
      $form.find('.payment-errors').text(response.error.message).show()
      $form.find('button').prop('disabled', false)
    else
      token = response.id
      $form.append($('<input type="hidden" name="stripeToken" />').val(token))
      $form.get(0).submit();

  $('#payment-form').submit (event) ->
    $form = $(this)
    $form.find('button').prop('disabled', true)
    Stripe.createToken($form, stripeResponseHandler)
    false
