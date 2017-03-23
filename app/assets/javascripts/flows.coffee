# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ($) ->

$(document).on('nested:fieldAdded', (event) ->
  if $('.sortable').length > 0
    $('.sortable').trigger("sortupdate")
    positions = Array.from($('input:hidden.approval_flow_positions').map ->
      return parseInt(this.value)
    .filter (bb,aa) ->
      return Number.isInteger(aa)
    )
    if positions.length == 0
      next_position = 1
    else
      next_position = Math.max.apply(null, positions) + 1
    $(event.target).find('input:hidden.approval_flow_positions').val(next_position)
    console.log('hoge')
    $('.sortable').sortable
      items: '.item'
      update: (e, ui) ->
        $('input:hidden.approval_flow_positions').each (index,b) ->
          $(b).val(index+1)
    $('.sortable').sortable('option', 'update')
  # 初期状態でroleで選択
  $(event.target).find('.auth_type').val('auth_by_role')
  $(event.target).find('.auth_by_user').closest('.form-group').hide()
  $(event.target).find('.auth_type').on('change', (e) =>
    $(e.target).closest('.row').find( '.auth_pattern').closest('.form-group').toggle()
  )

)

$(document).on('nested:fieldRemoved', (event) ->
  $('input:hidden.approval_flow_positions').each (index, element) ->
    $(element).val(index+1)
)
$(document).on('turbolinks:load', (e) ->
  if $('#flow-form').length > 0
    $('.sortable').sortable
      items: '.item'
      update: (e, ui) ->
        $('input:hidden.approval_flow_positions').each (index,b) ->
          $(b).val(index+1)
)
