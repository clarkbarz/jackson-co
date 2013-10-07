# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# simple jquery image gallery

jQuery ->
	$(document).ready ->
		$('img.thumb-image').click ->
			source = $(this).attr('src')
			$('img#main-image').fadeTo('fast', 0, ->
				$('img#main-image').attr('src', source) )
			$('img#main-image').delay(100).fadeTo('fast', 1)
		$('select#color_id').change ->
			source = $('img#main-image').attr('src').split('/')
			source[4] = $('select#color_id').val()
			clr_ids = []
			$('img.thumb-image').each( ->
				clr_ids.push( $(this).attr('src').split('/')[4] ) )
			if source[4] in clr_ids
				$('img#main-image').fadeTo('fast', 0, ->
					$('img#main-image').attr('src', source.join("/")) )
				$('img#main-image').delay(100).fadeTo('fast', 1)