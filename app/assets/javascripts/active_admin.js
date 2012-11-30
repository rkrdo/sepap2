//= require facebox
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-tokeninput
// require active_admin/base

$(document).ready(function () {
    $("#type_autocomplete").tokenInput("/admin/problems/type_tokens.json", {
    	crossDomain: false,
    	allowCustomEntry: true,
	preventDuplicates: true
    });

    $("#type_autocomplete_search").tokenInput("/admin/problems/type_tokens.json", {
    	crossDomain: false,
    	allowCustomEntry: false
    });
});

jQuery(document).ready(function($) {
  $('a[rel*=facebox]').facebox() 
})

$.facebox.settings.closeImage = '../assets/images/closelabel.png'
$.facebox.settings.loadingImage = '../assets/images/loading.gif'