$(document).ready ->

  slideout = new Slideout
    panel: document.querySelector '[data-slideout-panel]'
    menu:  document.querySelector '[data-slideout-menu]'
    side:  'right'

  $(document).on 'click', '[data-slideout-toggle]', => slideout.toggle()
