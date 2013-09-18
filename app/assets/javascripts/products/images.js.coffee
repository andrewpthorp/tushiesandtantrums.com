class ProductsImagesView extends Backbone.View
  el: '.focal-point'

  events:
    'click .image-thumb'    : 'changeImage'

  initialize: ->
    @$image = @$ '.product-image'

  changeImage: (ev) =>
    @$image.attr('src', $(ev.currentTarget).data('src'))

window.ProductsImagesView = ProductsImagesView
