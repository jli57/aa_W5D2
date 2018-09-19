# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $(document).ready ->
# ()-> 
#   $'.edit-comment-button'.click (e) ->
#     return alert('asf');
    # console.log("I'm printed")
    # $ '.edit-comment-form'
      # .css 'display', 'block'
toggle_edit = true
toggle_reply = true
$ -> 
  $('.edit-comment-button').click ->
    
    console.log(event.target.id)
    if toggle_edit
      $ '#comment-contents-' + event.target.id
        .css 'display', 'none'
      $ '#edit-comment-form-' + event.target.id
        .css 'display', 'block'
      toggle_edit = false
    else 
      $ '#comment-contents-' + event.target.id
        .css 'display', 'block'
      $ '#edit-comment-form-' + event.target.id
        .css 'display', 'none'
      toggle_edit = true

  $('.reply-comment-button').click ->
    if toggle_reply 
      $ '#reply-comment-form-' + event.target.id
        .css 'display', 'block'
      $ '#reply-comment-button-' + event.target.id
        .css 'display', 'none'
      toggle_reply = false
    else 
      $ '#reply-comment-form-' + event.target.id
        .css 'display', 'none'
      $ '#reply-comment-button-' + event.target.id
        .css 'display', 'inline'
      toggle_reply = true

      