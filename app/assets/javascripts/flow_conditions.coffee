# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready turbolinks:load', ->
  @condition_is_added = (event) ->
    return $(event.currentTarget.activeElement).data('association') == 'flow_conditions' ? true : false
  @condition_option_is_added = (event) ->
    return $(event.currentTarget.activeElement).data('association') == 'flow_condition_options' ? true : false
  if $('.flow_condition_group_form').length
    $('.flow_condition').each ->
      if $(@).find('.flow_condition_related_model').val() == '' || $(@).find('.flow_condition_group_compare_type').val() == ''
        #初期状態では隠す
        $(@).find('.flow_condition_option_add_button').hide()
      if $(@).find('.flow_condition_related_model').val() != '' &&  $(@).find('.flow_condition_group_compare_type').val() != ''
        #既存レコードをチェックして使わない項目は非表示に
        if $.inArray($(@).find('.flow_condition_related_model').val(),  ['category', 'sub_category']) > -1
          $(@).find('.flow_condition_compare_value').hide()
        if $.inArray($(@).find('.flow_condition_related_model').val(), ['price','initial_cost', 'time_required', 'personal_number']) != -1
          $(@).find('.flow_condition_group_flow_conditions_relation_id select').hide()



$(document).on('nested:fieldAdded', (event) ->
  #実行制御
  if $('.flow_condition_group_form').length
    if condition_is_added(event)
      #初期状態では隠す
      $(event.target).find('.flow_condition_option_add_button').hide()
      if $('.flow_condition_group_form').length
        #変更時の挙動を追加
        $('.flow_condition_related_model,.flow_condition_group_compare_type').change ->
          #両方データが入ったらinput boxを出す
          if $(@).closest('.row').find('.flow_condition_related_model').val() && $(@).closest('.row').find('.flow_condition_group_compare_type').val()
            if $.inArray($(@).closest('.row').find('.flow_condition_related_model').val(),  ['category', 'sub_category','shop']) > -1
              $(@).closest('.panel-body').find('.flow_condition_option_add_button').show()
            else if $.inArray($(@).closest('.row').find('.flow_condition_related_model').val(), ['price','initial_cost', 'time_required', 'personal_number']) != -1
              #input boxを出す条件
              $(@).closest('.panel-body').find('.flow_condition_option_add_button').show()
          else if $(@).closest('.row').find('.flow_condition_related_model').val() == '' \
          || $(@).closest('.row').find('.flow_condition_group_compare_type').val() == ''
            #どちらかが空になったらoptionの追加ボタンを隠してすでに追加された要素を削除
            $(@).closest('.panel-body').find('.flow_condition_option_add_button').hide()
            $(@).closest('.panel-body').find('.flow_condition_relation_id').val(null)
            $(@).closest('.panel-body').parent.find('.flow_condition_compare_value').val(null)
    else if condition_option_is_added(event)
      #optionが追加された時はajaxでoptionのデータを取得する
      target = event.target
      parent = $(target).closest('.panel-body')
      #optionsが追加された場合親要素(flow_condition)のrelation_type(category,price,initial_cost)の変更をできなくする
      parent.find('.flow_condition_related_model').disableSelection()
      $("input", {
        class: '.help-block',
        text: 'hogehoge'
      }).insertAfter(
        parent.find('.flow_condition_related_model')
      )
      if parent.length
        if parent.find('.flow_condition_related_model').val() && parent.find('.flow_condition_group_compare_type').val()
          if parent.find('.flow_condition_related_model').val() == 'category'
            #compare_valueは使わないので値を空にして,見えなくする
            parent.find('.flow_condition_compare_value').val(null).hide()
            url = '/categories'
            $.ajax url,
              type: 'GET'
              dataType: 'json'
              error: (jqXHR, textStatus, errorThrown) ->
                console.log("AJAX Error: #{textStatus}")
              success: (data, textStatus, jqXHR) =>
                update_select_box_option(parent.find('.flow_condition_relation_id').last(), data)
          if parent.find('.flow_condition_related_model').val() == 'sub_category'
            #compare_valueは使わないので値を空にして,見えなくする
            parent.find('.flow_condition_compare_value').val(null).hide()
            #sub_category追加時にはcategoryで選択中のものを取得してselectboxの条件を追加する
            category = $('.flow_condition_related_model').filter ->
              return $(@).val() == 'category'
            relation_type = $(category).closest('.panel-body').find('.flow_condition_related_model[unselectable=on]').val()
            category_ids = $(category).closest('.panel-body').find('.flow_condition_option select:visible')
              .map -> return $(@).val()
              .toArray()
            if category_ids.length == 0
              category_ids = Array.from([$(category).closest('.panel-body').find('.flow_condition_compare_value').val()])
            url = '/sub_categories'
            $.ajax url,
              type: 'GET'
              dataType: 'json'
              data: category_ids: category_ids
              error: (jqXHR, textStatus, errorThrown) ->
                console.log("AJAX Error: #{textStatus}")
              success: (data, textStatus, jqXHR) =>
                update_select_box_option(parent.find('.flow_condition_group_flow_conditions_relation_id select').last(), data)
          if $.inArray(parent.find('.flow_condition_related_model').val(), ['price','initial_cost', 'time_required', 'personal_number']) != -1
            #price,initial_constなどのときはtextボックスを出す
            parent.find('.flow_condition_group_flow_conditions_relation_id select').val(null).hide()
            parent.find('.flow_condition_compare_value').show()
          else
            $('.flow_condition_relation_id').show()
            $('.flow_condition_compare_value').hide()
)
$(document).on('nested:fieldRemoved', (event) ->
  if $(event.currentTarget.activeElement).data('association') == 'flow_condition_options'
    $link = $(event.target).siblings('a.add_nested_fields')
    if $link.siblings('div.fields:visible').length == 0
      $('.flow_condition_related_model').enableSelection()
)

