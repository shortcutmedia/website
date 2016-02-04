FIX_THRESHOLD = 500 # px
THROTTLE_INTERVAL = 200 # ms
ANIMATION_TIME = 233 # ms

class FixedHeaderSensor

  constructor: ->
    @fixed = null
    @body = $('body')
    @navbar = $('#site_navbar')

    @setScrollPosition()

  navbarHeight: ->
    @navbar.outerHeight true

  setScrollPosition: =>
    pos = window.scrollY

    if pos > FIX_THRESHOLD
      @fixHeader()
    else
      @unfixHeader()

  fixHeader: ->
    return if @fixed == true

    @body.css 'padding-top', @navbarHeight()
    @navbar.addClass 'navbar-fixed-top is-fixed'
    @navbar.animate 'margin-top': 0, ANIMATION_TIME

    @fixed = true

  unfixHeader: ->
    return if @fixed != true

    @navbar.animate 'margin-top': -100, ANIMATION_TIME, =>
      @navbar.removeClass 'navbar-fixed-top is-fixed'
      @body.css 'padding-top', ''
      @navbar.css 'margin-top', ''

    @fixed = false

$ ->
  $(window).on 'scroll', Utils.throttle((new FixedHeaderSensor).setScrollPosition, THROTTLE_INTERVAL)