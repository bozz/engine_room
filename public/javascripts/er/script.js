/* Author: 

*/

$(document).ready(function() {

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





















