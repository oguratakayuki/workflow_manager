jQuery ($) ->
  if $('#login-modal:visible').length
    console.log('hoge')
  $('#request_category_id').change ->
    url = "/categories/" + $(@).val() + "/sub_categories"
    $.ajax url,
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        update_select_box_option($('#request_sub_category_id'), ret)
        console.log(data)

  update_select_box_option(selectbox, options) ->
    selectbox.find('option').remove()
    selectbox.append($('<option>').prop('selected',true) )
    isSelected = true
    $.each(options, function (value, name) ->
        $option = $('<option>')
            .val(value)
            .text(name)
        selectbox.append($option)
    )


