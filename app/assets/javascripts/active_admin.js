//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-tokeninput
//= require facebox
//= require active_admin/base

$.facebox.settings.closeImage = '/assets/closelabel.png'
$.facebox.settings.loadingImage = '/assets/loading.gif'
$(document).ready(function($) {
  $('a[rel*=facebox]').facebox()
})
