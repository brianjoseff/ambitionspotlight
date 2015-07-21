# type in hashtag
## activate autocomplete
# on selecting something from dropdown--set up data for association -> hashtag_id
#- if no matches from autocomplete--return and:
#-- create tag and create association to post via tagging
#-- and user via user_tagging (so we can keep track of tags users use)

# type in !!
## activate autocomplete
# on selecting something from dropdown--set up data for association -> bangbang_id
#- if no matches from autocomplete--return and:
#-- create bangbang and create association to post via bangbanging
#-- and user via user_bang_banging (so we can keep track of bangbangs users use)

# type space
## close autocomplete

$(document).ready ->
  bangCounter = 0
  $('#post_goals').on 'keydown', (e) ->      
    switch e.which
      when 51 #3 
        if e.shiftKey #3 key down while shift is held
          ready("tag")
          console.log "done"        
        return
      when 35 # hashtag      
        # do same thing
        # I guess this is for mobile? or if user somehow types hashtag directly
        console.log "hey"
        ready("tag")
      when 49 #1
        if e.shiftKey
          bangCounter += 1
          if bangCounter is 1
            console.log "ONE BANG!"          
            return
          else if bangCounter is 2
            ready("bangbang")
            console.log "TWO BANG!!"
            #do autocomplete
          else
            console.log "TOO MANY BANGS?"
            bangCounter = 0
            return
        return
      when 33 #!
        #TO DO: do same thing for bangbang. this is for mobile?
        console.log "hello"
      when 50 #2 # @/at sign
        if e.shiftKey
          ready("at")
        return
    return
  #TO DO: add support for touch/mobile
  
split = (val) ->
  val.split(" ")

extractLast = (term) ->
  # console.log "before: ", term
  return split(term).pop()

stripHashTag = (lastTerm) ->
  stripped = lastTerm.slice(1)
  # regEx = new RegExp('\S*#(\S+)','g')
  # strippedLastTerm = lastTerm.replace(regEx, '')
  # console.log "stripped: ", strippedLastTerm
  return stripped
 

ready = (obj_type) ->
  $('a[href="' + @location.pathname + '"]').parent().addClass 'active'
  console.log "called autocomplete"
  normalized = {}
  lastKeyDown = 0
  $('#post_goals').bind( 'keydown', (event) ->
      lastKeyDown = event.keyCode
      # if event.keyCode is 32 #spacebar
      #   console.log "x"

  ).autocomplete(
        
    source: (request, response) ->      
      term = extractLast(request.term)
      if term.charAt(0) is "#" || "!"
        # if data doesn't have # prefix
        #strippedTerm = term.slice(1)
        if lastKeyDown is 32 #spacebar
          req_a = split(request.term)          
          penultimate_element = req_a[req_a.length - 2]
          $('<input>',
            name: "post[new_" + obj_type + "_titles][]"
            value: penultimate_element
            type: "hidden"
            multiple: "multiple"
            id: "new_post_" + obj_type + "_titles"
            ).appendTo("#hidden_fields")
          return

        $.getJSON '/posts/autocomplete_' + obj_type + 's.json', { term: term }, response
      else
        $( "#post_goals" ).blur().focus()
        if lastKeyDown is 32 #spacebar
          req_a = split(request.term)          
          penultimate_element = req_a[req_a.length - 2]
          $('<input>',
            name: "post[new_" + obj_type + "_titles][]"
            value: penultimate_element
            type: "hidden"
            multiple: "multiple"
            id: "new_post_" + obj_type + "_titles"
            ).appendTo("#hidden_fields")          
      return

    focus: ->
      # prevent value inserted on focus
      false

    select: (event, ui) ->
      terms = split @value
      terms.pop()
      
      #if data doesn't have # prepended
      #terms.push "#"+ ui.item.title
      
      terms.push ui.item.title
      terms.push("")
      @value = terms.join(" ")

      # $('#post_goals').val ui.item.title
      # $('#post_goal_id').val ui.item.id

      # TO DO: allow deletion of tags from text box and reflect deltion in removal of this from DOM
      # $('#post_goal_ids').val ui.item.id
      $('<input>',
        name: "post[" + obj_type + "_ids][]"
        value: ui.item.id
        type: "hidden"
        multiple: "multiple"
        id: "post_" + obj_type + "_ids"
        ).appendTo("#hidden_fields")

      event.preventDefault()
      return

    response: (event, ui) ->
      if ui.content.length is 0
        # $("#post_goals").autocomplete("disable")
        if lastKeyDown is 32 #spacebar
          return false
        #create new tag
        #add to normalization div
      else
        #add to normalization div
        return false

  ).data('uiAutocomplete')._renderItem = (ul, item) ->
    $('<li></li>').data('item.autocomplete', item).append('<a>' + item.title + '</a>').appendTo ul

  return

# $(document).ready ready
# $(document).on 'page:load', ready

bindings = ->
  $('[id^=edit_da_]').click ->
    da_id = $(this).attr('id').split('_')[2]
    $('#da_' + da_id).hide()
    $('#edit_form_' + da_id).removeClass 'hidden'
    return
  $('[id^=da_]').hover ->
    console.log $(this).next('div.button-hover')
    $(this).children().next('.button-hover').toggle()
    return
  $('.upload').change ->
    $input = undefined
    e = undefined
    inputFile = undefined
    inputFiles = undefined
    reader = undefined
    try
      $input = $(this)
      inputFiles = @files
      if inputFiles == undefined or inputFiles.length == 0
        return
      inputFile = inputFiles[0]
      reader = new FileReader
      #preview = $('#preview_upload')
      preview = $(this).parent().next('#preview_upload')
      console.log 'FUCKING PREVIEW', preview

      reader.onload = (event) ->
        preview.removeClass 'hidden'
        preview.empty()
        preview.attr 'src', event.target.result
        return

      reader.onerror = (event) ->

      reader.readAsDataURL inputFile
    catch _error
      e = _error
      console.log e
    return
  return

$(document).ready ->
  bindings()
  return
