# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->

  $('#bookmark-import').click (e) ->
    $('.modal').modal('show')

  $('.modal-dialog form input[type="submit"]').click (e) ->
    console.log 'fuga'
    $('.modal').modal('hide')

  $("#bookmark-import-form").on("ajax:success", (e, data, status, xhr) ->
    #$("#new_article").append xhr.responseText
    console.log 'success!!!!'
    console.log xhr.responseText
    console.log data
  ).on "ajax:error", (e, xhr, status, error) ->
    toastr.success('importを開始しました')
    console.log 'fail!!!!'
    console.log e
    console.log xhr
    console.log status
    console.log error
    console.log xhr.responseText


