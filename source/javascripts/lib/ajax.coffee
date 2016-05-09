window.SC.lib_ajax =

  check_status: (response) ->
    if response.status >= 200 && response.status < 300
      response
    else
      error = new Error response.statusText
      error.response = response
      throw error
