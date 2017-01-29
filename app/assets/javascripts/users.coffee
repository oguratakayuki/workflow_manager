$(document).on 'ready turbolinks:load', ->
  $('#request_category_id').change ->
    url = "/categories/" + $(@).val() + "/sub_categories"
    $.ajax url,
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        update_select_box_option($('#request_sub_category_id'), data)
