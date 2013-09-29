// simple jquery product image gallery

$(document).ready(function() {
	$('img.thumb-image').click(function() {
		var source = $(this).attr('src');
		$('img#main-image').fadeTo('fast', 0, function() {
			$('img#main-image').attr('src', source)
		});
		$('img#main-image').fadeTo('fast', 1);
	});
});