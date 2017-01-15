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

$(document).on('nested:fieldAdded', (event) ->
  target = event.target
  $(target).find('.request_costs_initial_cost').hide()
  $(target).find('.request_costs_cost_price_type').val('one_time')
  if $('.request_costs_cost_price_type').length > 0
    $(event.target).find('.request_costs_cost_price_type').change (event) ->
      if $(event.target).val() == 'one_time'
        $(target).find('.request_costs_initial_cost').hide()
      else
        $(target).find('.request_costs_initial_cost').show()
)
