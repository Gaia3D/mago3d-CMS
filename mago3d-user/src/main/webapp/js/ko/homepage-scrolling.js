	$(document).ready(function(){
		$(window).scroll(function(e){
			var nav = $('.nav');
			var header = $('header');
			var windowScrollTop = $(window).scrollTop()
			var navOffsetTop = nav.offset().top;
			var headerBottom = 0;
			if(header.length)
			{
				headerBottom = header.offset().top + header.outerHeight();
			}
			
			if((navOffsetTop < windowScrollTop) || (headerBottom < windowScrollTop)){
				nav.offset({top:windowScrollTop});
			}else if(headerBottom > windowScrollTop){
				nav.offset({top:headerBottom});
			}
		});
	});