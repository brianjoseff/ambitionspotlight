# type in hashtag
## activate autocomplete
# on selecting something from dropdown--set up data for association -> hashtag_id
# if no matches from autocomplete--return
# create tag and create association in rails controller

# type in !!
## activate autocomplete
# on selecting something from dropdown--set up data for association -> bangbang_id
# if no matches from autocomplete--return
# create tag and create association in rails controller

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
        console.log "hey"
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
        #do same thing
        console.log "hello"
      when 50 #2 # at sign
        if e.shiftKey
          ready()
        return
    return
  #TO DO: add support for touch/mobile
  
split = (val) ->
  val.split(" ")

extractLast = (term) ->
  console.log "before: ", term
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
        
        # console.log "1. -------------"
        # console.log "request", request
        # console.log "should be your tag: ", extractLast(request.term)
        $.getJSON '/posts/autocomplete_' + obj_type + 's.json', { term: term }, response
        # console.log "response: ", response
        # console.log "/1. -------------"
      else
        $( "#post_goals" ).blur().focus()
        if lastKeyDown is 32
          req_a = split(request.term)          
          penultimate_element = req_a[req_a.length - 2]
          # console.log "source--we believe it's a space"
          # console.log "and the term is: '", req_a, "'"
          # console.log "and here's the split term: '",penultimate_element , "'"
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
      #console.log "2. -------------"
      #console.log "ui: ", ui
      terms = split @value
      #console.log "terms: ", terms
      terms.pop()
      
      #if data doesn't have # prepended
      #terms.push "#"+ ui.item.title
      
      terms.push ui.item.title
      #console.log "updated terms: ", terms
      terms.push("")
      #console.log "updated terms 2: ", terms
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
      #console.log "/2. -------------"
      return

    response: (event, ui) ->
      console.log "response ui:", ui
      if ui.content.length is 0
        # console.log "LAST KEY DOWN: ", lastKeyDown
        # $("#post_goals").autocomplete("disable")
        # console.log "response event: ", event
        if lastKeyDown is 32 #spacebar
          console.log "actually a motherfuckin spacebar!!!"
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

