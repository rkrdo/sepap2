$(document).on "nested:fieldAdded", (event) ->
  total_cases = $(".case_number").size()
  case_num = event.field.find('.case_number')
  case_num.text(total_cases)

jQuery ->
  locale = $("#current_locale").val()
  if locale is "en"
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

  $("#mainEditor").html $("#problem_main").val()
  editor = ace.edit "mainEditor"
  editor.setTheme "ace/theme/textmate"
  editor.getSession().setMode "ace/mode/c_cpp"
  editor.setHighlightActiveLine false
  editor.setShowPrintMargin false
  editor.getSession().setTabSize 2
  editor.getSession().setUseSoftTabs false
  $("#problem_main").val ""

  resizeAce = ->
    $("#mainEditor").height $("#problem_main").outerHeight()
    $("#mainEditor").width $("#problem_main").outerWidth()
    $("#methodEditor").height $("#problem_main").outerHeight()
    $("#methodEditor").width $("#problem_main").outerWidth()
  $("#methodEditor").html $("#problem_method").val()
  meditor = ace.edit("methodEditor")
  meditor.setTheme "ace/theme/textmate"
  meditor.getSession().setMode "ace/mode/c_cpp"
  meditor.setHighlightActiveLine false
  meditor.setShowPrintMargin false
  meditor.getSession().setTabSize 2
  meditor.getSession().setUseSoftTabs false
  $("#problem_method").val ""
  $("#problem_command_id").change ->
    lang = $(this).val()
    if lang is "1" or lang is "2"
      editor.getSession().setMode "ace/mode/c_cpp"
      meditor.getSession().setMode "ace/mode/c_cpp"
    else if lang is "3"
      editor.getSession().setMode "ace/mode/csharp"
      meditor.getSession().setMode "ace/mode/csharp"
    else
      editor.getSession().setMode "ace/mode/java"
      meditor.getSession().setMode "ace/mode/java"

  $(window).resize resizeAce
  resizeAce()
  $("form").on "submit", ->
    $("#problem_main").val editor.getSession().getValue()
    $("#problem_method").val meditor.getSession().getValue()
