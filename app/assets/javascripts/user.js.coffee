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
  
  $(document).on 'click', '.destroy-activity', "current-activity", (e) ->
    activity_holder = $(this).closest('.current-activity')
    activity_holder.toggleClass('delete-activity')
    temp_id = $(this).data('temp-id')
    console.log(temp_id)
    activity_holder.data('temp-id', temp_id)
  
  $(document).on 'click', '.ad-lib-link', "bio-fields", (e) ->
    e.preventDefault()
    $(".ad-lib").toggle()
    $(".free-form").toggle()
    $("a.ad-lib-link").toggleClass('inactive-link')
    $("a.free-form-link").toggleClass('inactive-link')
  
  fb_share = (o) ->
    console.log(o.data("link"))
    FB.ui
      method: 'share'
      href: o.data("link")
      
      # href: "ambitionspotlight.com"
  
    , (response) ->
    
    return
  
  $(".fb-share-link").click (e) ->
    console.log(e)
    e.preventDefault()
    fb_share($(e.target))
    
    return
  
  # ------------------------------------------------------
  # pretty-fy the upload field
  # ------------------------------------------------------
  $realInputField = $('#user_profile_photo')

  # drop just the filename in the display field
  $realInputField.change ->
    $('#file_display').html $(@).val().replace(/^.*[\\\/]/, '')
    $('.submit-profile-photo').show()

  # trigger the real input field click to bring up the file selection dialog
  $('#upload_btn').click ->
    $realInputField.click()
  # fb_share = ->
  # 
  #   # facebook share dialog
  #   FB.ui
  #     method: "feed"
  #     name: "Ambition Spotlight"
  #     href: @data('link')
  #     picture: @data('image')
  #     caption: @data('description')
  #   , (response) ->

  #$(document).on "click", ".fb-share-link", "share", fb_share
  # $(document).on 'click', '.fb-share-link', "share", (e) ->
  #   e.preventDefault()
  #   FB.ui
  #     method: "share"
  #     href: @data('link')
  #   , (response) ->
  
$(document).ready(ready)


  
