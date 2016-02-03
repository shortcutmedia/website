FIX_THRESHOLD = 500 # px
HEADER_HEIGHT = 93 # px
THROTTLE_INTERVAL = 200 # ms

class FixedHeaderSensor

  constructor: ->
    @fixed = null
    @setScrollPosition()

  setScrollPosition: =>
    pos = window.scrollY

    if pos > FIX_THRESHOLD
      @fixHeader()
    else
      @unfixHeader()

  fixHeader: ->
    return if @fixed == true

    navbar = $('#site_navbar')
    navbar.addClass 'navbar-fixed-top is-fixed'
    $('body').css 'padding-top', HEADER_HEIGHT

    @fixed = true

  unfixHeader: ->
    return if @fixed == false

    navbar = $('#site_navbar')
    navbar.removeClass 'navbar-fixed-top is-fixed'
    $('body').css 'padding-top', 0

    @fixed = false

$ ->
  $(window).on 'scroll', Utils.throttle((new FixedHeaderSensor).setScrollPosition, THROTTLE_INTERVAL)