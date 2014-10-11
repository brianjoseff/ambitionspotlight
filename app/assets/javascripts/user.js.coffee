ready = ->
  $(document).on 'click','.free-form-link', 'bio-fields', (e) ->
    e.preventDefault()
    # e.stopPropagation()
    $(this).toggleClass('inactive-link')
    $("a.ad-lib-link").toggleClass('inactive-link')
    $(".ad-lib").toggle()
    $(".free-form").toggle()
  
  $('a.change-password').click (e) ->
    e.preventDefault()
    $('div.change-password-veil').toggle()
  

  $(document).on 'click', '.ad-lib-link', "bio-fields", (e) ->
    e.preventDefault()
    $(".ad-lib").toggle()
    $(".free-form").toggle()
    $("a.ad-lib-link").toggleClass('inactive-link')
    $("a.free-form-link").toggleClass('inactive-link')

$(document).ready(ready)
$(document).on('page:load', ready)


  