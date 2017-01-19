jQuery ($) ->
  update_select_box_option = (selectbox, options) ->
    selectbox.find('option').remove()
    selectbox.append($('<option>').prop('selected',true) )
    isSelected = true
    $.each(options, (index, name) ->
        temp = Array.from($(@))
        $option = $('<option>')
            .val(temp[0])
            .text(temp[1])
        selectbox.append($option)
    )

  $('#request_category_id').change ->
    url = "/categories/" + $(@).val() + "/sub_categories"
    $.ajax url,
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        update_select_box_option($('#request_sub_category_id'), data)
