$(document).on 'click', '.doc-toc a', ->

  el = $ @
  navRoot = el.parents '.doc-toc'

  navRoot.find('li.active').removeClass('active')
  el.parentsUntil(navRoot, 'li').addClass('active')


  console.log el.parentsUntil(navRoot, 'li')





