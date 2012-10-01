//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-tokeninput
//= require active_admin/base

$(document).ready(function () {
    $("#type_autocomplete").tokenInput("/admin/problems/type_tokens.json", {
    	crossDomain: false,
    	allowCustomEntry: true
    });
});