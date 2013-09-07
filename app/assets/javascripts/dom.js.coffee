class DomView extends Backbone.View
  el: 'body'

  events:
    'ajax:complete'                 : 'ajaxComplete'
    'mouseover .product-widget'     : 'widgetMouseover'
    'mouseout .product-widget'      : 'widgetMousetout'

  # widgetMouseout - handle when a user mouses over a product widget.
  widgetMouseover: (ev) ->
    $(ev.currentTarget).find('.overlay').removeClass 'hide'

  # widgetMouseout - handle when a user mouses out from a product widget.
  widgetMouseout: (ev) ->
    $(ev.currentTarget).find('.overlay').addClass 'hide'

  # ajaxComplete - figure out what the ajax was for, and execute it.
  ajaxComplete: (xhr, status) =>
    if status.getResponseHeader('Ajax-Type') == 'flash'
      @ajaxFlash(xhr, status)
    else if status.getResponseHeader('Ajax-Type') == 'popup'
      @ajaxPopup(xhr, status)

  # ajaxFlash - when an ajax request is complete, if it is for a flash, show it.
  ajaxFlash: (xhr, status) =>
    $flash = $ '.flash'

    if status.getResponseHeader('Flash-Message-Type') == 'success'
      $flash.removeClass 'error'
      $flash.addClass 'success'
      @delay 1500, ->
        @resetReveal()
    else
      $flash.removeClass 'success'
      $flash.addClass 'error'

    $flash.text status.getResponseHeader('Flash-Message')
    $flash.removeClass 'hide'

  # ajaxPopup - when an ajax request is complete, if it is for a poup, show it.
  ajaxPopup: (xhr, status) =>
    $popup = $(status.responseText)
    @$el.append($popup)

  # delay - makes working with setTimeout in CoffeeScript easier.
  delay: (time, fn, args...) ->
    setTimeout fn, time, args...

  # resetReveal - resets the Inquiry form.
  #
  # TODO: If we ever want to use reveals elswehere, need to generalize this.
  resetReveal: ->
    $flash = $ '.flash'
    $contact = $ '#contact'
    $contact.foundation 'reveal', 'close'

    $flash.addClass 'hide'
    $flash.text ''
    $contact.find('input[type=text]').val ''
    $contact.find('textarea').val ''


window.DomView = DomView
