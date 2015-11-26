
class BenefitsNav

  isOpen: false

  constructor: (navSelector, navToggleSelector) ->
    @navElement = $ navSelector
    @toggleButton = $ navToggleSelector

    @registerToggleButton()
    @registerItemLinks()
    @initActiveItem()

  toggleNav: ->
    @navElement.find('li').toggleClass('visible')
    @isOpen = !@isOpen

  itemClicked: (event) =>
    clickedLinked = $(event.currentTarget)
    clickedItem = clickedLinked.closest('li')

    # mark new item as active
    @clearActiveItem()
    clickedItem.addClass 'active'

    if @isCollapseableNav()
      unless @isOpen
        event.preventDefault()
      @toggleNav()
    true

  isCollapseableNav: -> @toggleButton.is ':visible'

  registerToggleButton: ->
    $(document).on 'click.bs.collapse', '[data-toggle="collapse-benefits"]', => @toggleNav()

  registerItemLinks: -> $('.benefits-nav a').on 'click', @itemClicked

  initActiveItem: ->
    if @currentPathHasFragment()
      requestedItem = @navElement.find("a[href='#{@currentPath()}']").closest('li')
      if requestedItem
        @clearActiveItem()
        requestedItem.addClass 'active'

  clearActiveItem: -> @navElement.find('li.active').removeClass 'active'

  currentPathHasFragment: -> window.location.hash != ''

  currentPath: -> window.location.pathname + window.location.hash


$(document).on 'ready', ->
  new BenefitsNav('.benefits-nav', 'button[data-toggle="collapse-benefits"]')

