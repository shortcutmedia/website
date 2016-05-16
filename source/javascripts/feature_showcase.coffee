detect_analytics_selected = (event) ->
  if event.target.getAttribute('id') == 'fs-analytics'
    $(event.target).parents('.FeatureShowcase').addClass 'collapse-demo-column'
  else
    $(event.target).parents('.FeatureShowcase').removeClass 'collapse-demo-column'

$(document).ready ->
  $(document).on 'change', '.FeatureShowcase', detect_analytics_selected
