$ ->

  $attempt_loading = $("#attempt-loading")
  $attempt_loading.hide() if $attempt_loading.length > 0

  #text editor
  if $("#attemptEditor").length > 0
    $("#attemptEditor").html $("#attempt_code").html()
    editor = ace.edit "attemptEditor"
    editor.setTheme "ace/theme/textmate"
    editor.getSession().setMode "ace/mode/c_cpp"
    editor.setHighlightActiveLine false
    editor.setShowPrintMargin false
    editor.getSession().setTabSize 2
    editor.getSession().setUseSoftTabs false
    $("#attempt_code").val ""

    resizeAce = ->
      $("#attemptEditor").height $("#attempt_code").outerHeight()
      $("#attemptEditor").width $("#attempt_code").outerWidth()

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

  $("a.reveal").click (event) ->
    event.preventDefault()
    div = $(".reveal-modal").addClass("large")
    $.get $(this).attr("href"), (data) ->
      div.children(".modal-content").empty().html data
    div.reveal()

  $("#new_attempt").on "submit", ->
    button = $("input[type=submit]")
    button.attr("disabled", true)
    $attempt_loading.show()
