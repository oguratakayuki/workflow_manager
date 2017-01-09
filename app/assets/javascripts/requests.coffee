# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->

  $('#bookmark-import').click (e) ->
    $('.modal').modal('show')

  $('.modal-dialog form input[type="submit"]').click (e) ->
    $('.modal').modal('hide')

  $("#bookmark-import-form").on("ajax:success", (e, data, status, xhr) ->
    #$("#new_article").append xhr.responseText
  ).on "ajax:error", (e, xhr, status, error) ->
    toastr.success('importを開始しました')


