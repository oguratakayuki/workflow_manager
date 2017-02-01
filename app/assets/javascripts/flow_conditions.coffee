# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ($) ->
  @condition_is_added = (elem) ->
    $(elem).find('.flow_condition_option_add_button').length == 1
  @condition_option_is_added = (elem) ->
    $(elem).find('.flow_condition_option_add_button').length == 0

$(document).on('nested:fieldAdded', (event) ->
  #実行制御
  if $('.flow_condition_group_form').length
    if condition_is_added(event.target)
      #初期状態では隠す
      $(event.target).find('.flow_condition_option_add_button').hide()
      if $('.flow_condition_group_form').length
        console.log 'hoge2'
        #変更時の挙動を追加
        $('.flow_condition_group_relation_type,.flow_condition_group_compare_type').change ->
          console.log 'hoge3'
          if $(@).closest('.row').find('.flow_condition_group_relation_type').val() && $(@).closest('.row').find('.flow_condition_group_compare_type').val()
            console.log 'hoge4'
            if $(@).closest('.row').find('.flow_condition_group_relation_type').val() == 'category'
              if $(@).closest('.row').find('.flow_condition_group_compare_type').val() == 'eq'
                $(@).closest('.panel-body').find('.flow_condition_option_add_button').show()
            else if $(@).closest('.row').find('.flow_condition_group_relation_type').val() == 'price'
              $(@).closest('.panel-body').find('.flow_condition_option_add_button').show()
          else if $(@).closest('.row').find('.flow_condition_group_relation_type').val() == '' \
          || $(@).closest('.row').find('.flow_condition_group_compare_type').val() == ''
            #どちらかが空になったらoptionの追加ボタンを隠してすでに追加された要素を削除
            $(@).closest('.panel-body').find('.flow_condition_option_add_button').hide()
            $(@).closest('.panel-body').find('.flow_condition_relation_id').val(null)
    else if condition_option_is_added(event.target)
      #optionが追加された時はajaxでoptionのデータを取得する
      target = event.target
      parent = $(target).closest('.panel-body')
      #optionsが追加された場合親要素(flow_condition)のrelation_type(category,price,initial_cost)の変更をできなくする
      parent.find('.flow_condition_group_relation_type').prop('disabled', true)
      $("input", {
        class: '.help-block',
        text: 'hogehoge'
      }).insertAfter(
        parent.find('.flow_condition_group_relation_type')
      )
      console.log('hogessss')



      if parent.length
        if parent.find('.flow_condition_group_relation_type').val() && parent.find('.flow_condition_group_compare_type').val()
          if parent.find('.flow_condition_group_relation_type').val() == 'category'
            if parent.find('.flow_condition_group_compare_type').val() == 'eq'
              url = '/categories'
              $.ajax url,
                type: 'GET'
                dataType: 'json'
                error: (jqXHR, textStatus, errorThrown) ->
                  console.log("AJAX Error: #{textStatus}")
                success: (data, textStatus, jqXHR) =>
                  update_select_box_option(parent.find('.flow_condition_relation_id'), data)
          if $.inArray(parent.find('.flow_condition_group_relation_type').val(), ['price','initial_cost']) != -1
            #price,initial_constなどのときはtextボックスを出す
            $("<input>", {
              type: 'text',
              class: '.flow_condition_group_relation_type'
            }).insertAfter(parent.find('.flow_condition_relation_id')).prev().remove()
          else
            console.log $.inArray(parent.find('.flow_condition_group_relation_type').val(), ['price'])

)
$(document).on('nested:fieldRemoved', (event) ->
  if $(event.currentTarget.activeElement).data('association') == 'flow_condition_options'
    $('.flow_condition_group_relation_type').prop('disabled', false)
)

