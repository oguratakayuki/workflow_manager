jQuery ($) ->
  @update_select_box_option = (selectbox, options) ->
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
    console.log selectbox


