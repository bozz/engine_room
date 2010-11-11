/* Author: 

*/

$(document).ready(function() {
	
	SyntaxHighlighter.all();
	
	$("aside").mouseover(function(){
		$(this).addClass('open');
	});
	$("aside").mouseout(function(){
		$(this).removeClass('open');
	});

});





















