load_deferred_images = ->
  setTimeout ->
    $('[data-deferred-image]').each (img) ->
      img = $ img
      img.attr 'src', img.attr 'data-deferred-image'
  , 100

$(document).ready load_deferred_images