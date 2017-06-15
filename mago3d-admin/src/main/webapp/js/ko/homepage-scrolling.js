	$(document).ready(function(){
		$(window).scroll(function(e){
			var nav = $('.nav');
			var header = $('header');
			var windowScrollTop = $(window).scrollTop()
			var navOffsetTop = nav.offset().top;
			var headerTop = header.offset().top;
			var headerHeight = header.outerHeight();
			var headerBottom = headerTop + headerHeight;
			if((navOffsetTop < windowScrollTop) || (headerBottom < windowScrollTop)){
				nav.offset({top:windowScrollTop});
			}else if(headerBottom > windowScrollTop){
				nav.offset({top:headerBottom});
			}
		});
	});