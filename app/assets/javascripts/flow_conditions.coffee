# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('nested:fieldAdded', (event) ->
  target = event.target
  parent = $(target).closest('.panel-body')
  if parent.length
    if parent.find('.flow_condition_group_relation_type').val() && parent.find('.flow_condition_group_compare_type').val()
      if parent.find('.flow_condition_group_relation_type').val() == 'category'
        if parent.find('.flow_condition_group_compare_type').val() == 'eq'
          url = "/categories"
          $.ajax url,
            type: 'GET'
            dataType: 'json'
            error: (jqXHR, textStatus, errorThrown) ->
              console.log("AJAX Error: #{textStatus}")
            success: (data, textStatus, jqXHR) =>
              update_select_box_option(parent.find('.flow_condition_relation_id'), data)
)

$(document).on 'turbolinks:load', ->
  $('.flow_condition_group_relation_type').each ->
    if $(@).closest('.row').find('.flow_condition_group_relation_type').val() == '' || $(@).closest('.row').find('.flow_condition_group_compare_type').val() == ''
      $(@).closest('.panel-body').find('.flow_condition_option_add_button').show()

  #$('.flow_condition_group_relation_type,.flow_condition_group_compare_type').change ->
  #  if $(@).closest('.row').find('.flow_condition_group_relation_type').val() && $(@).closest('.row').find('.flow_condition_group_compare_type').val()
  #    if $(@).closest('.row').find('.flow_condition_group_relation_type').val() == 'category'
  #      if $(@).closest('.row').find('.flow_condition_group_compare_type').val() == 'eq'
  #        $(@).closest('.panel-body').find('.flow_condition_option_add_button').show()
  #        url = "/categories"
  #        $.ajax url,
  #          type: 'GET'
  #          dataType: 'json'
  #          error: (jqXHR, textStatus, errorThrown) ->
  #            console.log("AJAX Error: #{textStatus}")
  #          success: (data, textStatus, jqXHR) =>
  #            console.log ($(@).closest('.panel-body'))
  #            update_select_box_option($(@).closest('.panel-body').find('.flow_condition_relation_id'), data)




    else
      console.log 'no'

    #if $(@).val() == 'category'
    #  console.log $(@).parent('.row').find('.flow_condition_group_compare_type').val()
    #  ret = $('.flow_condition_group_relation_type').filter ->
    #    return $(@).val() == 'sub_category'
    #  console.log ret



    #url = "/categories/" + $(@).val() + "/sub_categories"
    #$.ajax url,
    #  type: 'GET'
    #  dataType: 'json'
    #  error: (jqXHR, textStatus, errorThrown) ->
    #    console.log("AJAX Error: #{textStatus}")
    #  success: (data, textStatus, jqXHR) ->
    #    update_select_box_option($('#request_sub_category_id'), data)
