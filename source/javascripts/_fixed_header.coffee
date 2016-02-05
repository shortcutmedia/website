SOLID_THRESHOLD = 20 # px
THROTTLE_INTERVAL = 50 # ms

class FixedHeaderSensor

  constructor: ->
    @navbar = $('#site_navbar')
    @adjustHeader()

  adjustHeader: =>
    pos = window.scrollY

    if pos > SOLID_THRESHOLD
      @navbar.css 'margin-top', ''
      @navbar.addClass 'is-solid'
    else
      @navbar.css 'margin-top', SOLID_THRESHOLD - pos
      @navbar.removeClass 'is-solid'


$ ->
  $(window).on 'scroll', Utils.throttle((new FixedHeaderSensor).adjustHeader, THROTTLE_INTERVAL, { leading: false, trailing: true })