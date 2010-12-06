/* Author: 

*/

$(document).ready(function() {

  $("#tabs").tabs();

  $("#overview-fields-table tbody").sortable({
    axis: 'y',
    opacity: 0.6,
    stop: function(event, ui){
      ui.item.effect("highlight", {}, 500);
    }
  });
  //$("#overview-fields-table tbody").disableSelection();

  // automatically reload forms when select has changed
  $("form div.reload select").change(function(){
    var hiddenField = document.createElement('input');
    $(hiddenField).attr({
      type: 'hidden',
      name: 's_action',
      value: 'reload'
    });
    $("form").append(hiddenField).submit();
  });

});





















