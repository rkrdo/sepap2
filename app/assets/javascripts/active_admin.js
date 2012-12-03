//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-tokeninput
//= require facebox
//= require jquery.dataTables.min
//= require active_admin/base

$.facebox.settings.closeImage = '/assets/closelabel.png'
$.facebox.settings.loadingImage = '/assets/loading.gif'
$(document).ready(function($) {
  $('a[rel*=facebox]').facebox()
  $('.data_table').dataTable( {
		"sDom": 'R<"H"lfr>t<"F"ip>',
		"JQueryUI": true,
		"sPaginationType": "full_numbers"
	} );
  $("#spInfoMembers").hide();
  $("#spInfoMethod").hide();
  $("#spInfoMain").hide();
  $("#spInfoInput").hide();

  $("#infoMembers").mouseover(function(){
      $("#spInfoMembers").show();
    });

  $("#infoMembers").mouseout(function(){
      $("#spInfoMembers").hide();
    });

  $("#infoMethod").mouseover(function(){
      $("#spInfoMethod").show();
    });

  $("#infoMethod").mouseout(function(){
      $("#spInfoMethod").hide();
    });

  $("#infoMain").mouseover(function(){
      $("#spInfoMain").show();
    });

  $("#infoMain").mouseout(function(){
      $("#spInfoMain").hide();
    });

  $("#infoInput").mouseover(function(){
    $("#spInfoInput").show();
  });

  $("#infoInput").mouseout(function(){
      $("#spInfoInput").hide();
    });

})
