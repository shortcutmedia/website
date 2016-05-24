counter_is_present = ->
  $('[data-mobile-events-counter]').length > 0

fetch_event_count = ->
  fetch 'https://manager.shortcut.sc/statistics/total.json'
    .then window.SC.lib_ajax.check_status
    .then (response) -> response.json()
    .then (json) -> json.count

show_count = (count) ->
  count = parseInt count

  if typeof(count) == 'number' && !isNaN(count) && count > 10000
    digits = count.toString().split ''

    counter = $ '[data-mobile-events-counter]'
    html = digits.map(wrap_in_span).join ''
    counter.html html

    hidden_elements = counter.parent().children '.u-hidden'
    $(hidden_elements).removeClass 'u-hidden'

wrap_in_span = (digit) ->
  "<span>#{digit}</span>"


$(document).ready ->
  fetch_event_count().then(show_count) if counter_is_present()
