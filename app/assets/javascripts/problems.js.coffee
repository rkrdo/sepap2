$(document).on "nested:fieldAdded", (event) ->
  total_cases = $(".case_number").size()
  case_num = event.field.find('.case_number')
  case_num.text(total_cases)

jQuery ->
  locale = $(".locale_setter").text()
  if locale is "Spanish"
    tableLocale = "/assets/dataTables.english.txt"
  else
    tableLocale = "/assets/dataTables.spanish.txt"

  $(".data_table").dataTable
    "bJQueryUI": true
    "sPaginationType": "full_numbers"
    "bDestroy": true
    "oLanguage":
        "sUrl":   tableLocale

  $('.data_table').css('width', '')

  setTimeout ->
          hideFlashMessages()
      ,2500

      hideFlashMessages = ->
          $("div.alert-box").slideUp()
