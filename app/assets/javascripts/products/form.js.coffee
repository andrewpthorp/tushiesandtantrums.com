class ProductFormView extends Backbone.View
  el: '.product-form'

  events:
    'nested:fieldAdded:images'      : 'ensurePrimary'
    'nested:fieldRemoved:images'    : 'ensurePrimary'
    'change .primary-check'         : 'primaryChanged'
    'click .checkbox'               : 'checkClicked'

  # initFoundation - simply do any foundation work required.
  initFoundation: ->
    $(document).foundation()

  # ensurePrimary - when nested fields are added or removed, make sure we have
  #                 at least one primary image set.
  ensurePrimary: =>
    unless @$('.primary-check[checked=checked]:visible').length
      @$('.primary-check:visible').first().attr('checked', true)
    @initFoundation()

  # primaryChanged -  when a primary checkbox is changed, we will uncheck every
  #                   other primary checkbox.
  primaryChanged: (ev) =>
    @$('.primary-check').each ->
      $this = $(this)
      $this.attr('checked', ev.currentTarget == this)
    @initFoundation()

  # checkClicked -  when a custom checkbox (from foundation) is clicked, we want
  #                 to prevent it from doing anything if the checkbox is
  #                 currently checked.
  checkClicked: (ev) =>
    if $(ev.currentTarget).hasClass('checked')
      return false

window.ProductFormView = ProductFormView
