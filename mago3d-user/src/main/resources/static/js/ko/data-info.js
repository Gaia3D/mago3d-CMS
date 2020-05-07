$("#dataInfoTab li").click(function(){
	$("#dataInfoTab > li").not($(this)).each(function() {
        $(this).removeClass('on');
        $('#' + $(this).attr('data-nav')).hide();
    });
	$(this).addClass("on");
	$("#" + $(this).attr("data-nav")).show();
});