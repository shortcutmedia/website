removeValidationErrors = (form) ->
  form.find('small.error').remove()

sanitizeUrlInput = (field) ->
  field.val(field.val().trim())
  return if field.val() == ''

  unless field.val().match(/^https?:\/\//)
    field.val('http://' + field.val())

validateUrlInput = (field) ->
  return if field.val().trim() == ''

  # regex from https://gist.github.com/dperini/729294
  unless field.val().match(/^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})).?)(?::\d{2,5})?(?:[/?#]\S*)?$/i)
    field.after($('<small class="error">is not a valid http(s) url</small>'))
    return false
  else
    return true

$(document).on 'ready', ->
  $('.short-link-form input[type="url"]').on 'change', (e) ->
    sanitizeUrlInput($(@))
    removeValidationErrors($(@).parents('form'))

  $('.short-link-form').on 'submit', (e) ->
    form = $(@)

    # remove error messages
    removeValidationErrors(form)

    # validate url field
    field = form.find('input[type="url"]')
    return false unless field.val()
    return false unless validateUrlInput(field)

    # deactivate form after submission
    setTimeout( ->
      form.find('input').attr('disabled', true)
      form.find('button[type=submit]').val('Generating...')
    , 200)
