ready = ->

  $('a.change-password').click (e) ->
    e.preventDefault()
    $('div.change-password-veil').toggle()

$(document).ready(ready)
$(document).on('page:load', ready)
