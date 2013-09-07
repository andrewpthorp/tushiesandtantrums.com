$ ->

  $(document).on 'ajax:complete', (xhr, status) ->
    $popup = $(status.responseText)
    $('body').append($popup)
