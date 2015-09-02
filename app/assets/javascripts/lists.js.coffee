$ ->
  $('.list-description-link').click (e) ->
    e.preventDefault()
    $(".description").slideToggle()

  $('body').on 'click touch', 'a.add-nested-action', (event) ->
    event.preventDefault()
    time = (new Date).getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $('.action-container').append $(this).data('fields').replace(regexp, time)
    return
