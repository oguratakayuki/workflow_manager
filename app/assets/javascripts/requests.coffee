# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->

$(document).on('nested:fieldAdded', (e) ->
  link = $(e.currentTarget.activeElement)
  if (!link.data('limit'))
    return
  if (link.siblings('.fields:visible').length >= link.data('limit'))
    link.hide()
)

$(document).on('nested:fieldRemoved', (e) -> 
  link = $(e.target).siblings('a.add_nested_fields')
  if (!link.data('limit'))
    return
  if (link.siblings('.fields:visible').length < link.data('limit'))
    link.show()
)
