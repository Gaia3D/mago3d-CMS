$.noConflict();

jQuery(document).ready(function($) {
	
	"use strict";
	[].slice.call( document.querySelectorAll( 'select.cs-select' ) ).forEach( function(el) {
		new SelectFx(el);
	} );

	jQuery('.selectpicker').selectpicker;

	$('#menuToggle').on('click', function(event) {
		$('body').toggleClass('open');
	});
});