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

  $('.request_costs_cost_price_type').change ->
    console.log('hoge')

$(document).on('nested:fieldAdded', (e) ->
  if $('.request-form').length
    link = $(e.currentTarget.activeElement)
    if (!link.data('limit'))
      return
    if (link.siblings('.fields:visible').length >= link.data('limit'))
      link.hide()
)

$(document).on('nested:fieldRemoved', (e) -> 
  if $('.request-form').length
    link = $(e.target).siblings('a.add_nested_fields')
    if (!link.data('limit'))
      return
    if (link.siblings('.fields:visible').length < link.data('limit'))
      link.show()
)
