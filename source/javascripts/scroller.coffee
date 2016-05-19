close_enough = (a, b) ->
  a = Math.abs a
  b = Math.abs b

  a <= (b + 1.5) && a >= (b - 1.5)

# based on http://stackoverflow.com/a/24559613/2792897
scroll_window_to = (target_y, scrollDuration) ->
  target_y = parseInt target_y
  scrollDuration = parseInt scrollDuration

  scrollHeight = window.scrollY - target_y
  scrollStep = Math.PI / ( scrollDuration / 15 )
  cosParameter = scrollHeight / 2
  scrollCount = 0
  scrollMargin = 0

  step = ->
    setTimeout ->
      if !close_enough window.scrollY, target_y
        requestAnimationFrame step
        scrollCount = scrollCount + 1
        scrollMargin = cosParameter - cosParameter * Math.cos( scrollCount * scrollStep )
        window.scrollTo 0, (scrollHeight - scrollMargin) + target_y
    , 15

  requestAnimationFrame step


$(document).ready ->
  $('[data-scroll-to]').on 'click', ->
    [selector, duration] = $(this).attr('data-scroll-to').split ','
    target = $(selector).get 0

    if target?
      target_y = target.getBoundingClientRect().top + window.pageYOffset

      scroll_window_to target_y, (duration || 300)