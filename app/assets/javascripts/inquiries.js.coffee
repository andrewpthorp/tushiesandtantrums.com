# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

delay = (time, fn, args...) ->
  setTimeout fn, time, args...

resetReveal = ->
  $flash = $ '.flash'
  $contact = $ '#contact'
  $contact.foundation 'reveal', 'close'

  $flash.hide()
  $flash.text ''
  $contact.find('input[type=text]').val ''
  $contact.find('textarea').val ''

$ ->

  $(document).on 'ajax:complete', (xhr, status) ->
    $flash = $ '.flash'

    if status.getResponseHeader('Flash-Message-Type') == 'success'
      $flash.removeClass 'error'
      $flash.addClass 'success'
      delay 1500, ->
        resetReveal()
    else
      $flash.removeClass 'success'
      $flash.addClass 'error'

    $flash.text status.getResponseHeader('Flash-Message')
    $flash.show()

