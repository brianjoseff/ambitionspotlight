# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".list-description-link").click ->
    console.log "hello"

    $(".description").toggle()

  $('body').on 'click touch', 'a.add-nested-action', (event) ->
    console.log "efore evanet default"
    event.preventDefault()
    console.log "clicked add action"
    time = (new Date).getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $('.action-container').append $(this).data('fields').replace(regexp, time)
    #var currentValue = $("input[name='flow[rows_attributes][0][name]']").val();
    # $("input[name='flow[rows_attributes]["+time+"][name]']").val(currentValue);
    # $("input[name='flow[rows_attributes][0][name]']").val('');
    # $(".add-nested-row").removeClass("hover");
    return

  # $('#create_list').on 'click touch', (e) ->
  #   e.preventDefault()