jQuery ->
  #text editor
  $("#mainEditor").html $("#attempt_code").val()
  editor = ace.edit "mainEditor"
  editor.setTheme "ace/theme/textmate"
  editor.getSession().setMode "ace/mode/c_cpp"
  editor.setHighlightActiveLine false
  editor.setShowPrintMargin false
  editor.getSession().setTabSize 2
  editor.getSession().setUseSoftTabs false
  $("#attempt_code").val ""

  resizeAce = ->
    $("#mainEditor").height $("#attempt_code").outerHeight()
    $("#mainEditor").width $("#attempt_code").outerWidth()
    
  $("#attempt_command_id").change ->
    lang = $(this).val()
    if lang is "1" or lang is "2"
      editor.getSession().setMode "ace/mode/c_cpp"
    else if lang is "3"
      editor.getSession().setMode "ace/mode/csharp"
    else
      editor.getSession().setMode "ace/mode/java"

  $(window).resize resizeAce
  resizeAce()
  $("form").on "submit", ->
    $("#attempt_code").val editor.getSession().getValue()
