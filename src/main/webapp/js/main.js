$(function(){

	$('.main_slider').bxSlider({
		speed: 500,
		mode: 'fade',
		autoControls: false,
		controls: false,
	});

	$('.main_accordion dt').click(function() {
		$('.main_accordion dt').removeClass('on');
		$(".main_accordion dd").stop().slideUp("fast");	
		if (!$(this).parent().next("dd").is(":visible")) {
			$(this).addClass('on');
			$(this).next().stop().slideDown();
		}
		return false;
	});

	$('.term_slider').bxSlider({
		speed: 500,
		autoControls: false,
		pager: true,
		pagerType: 'short',
		pagerShortSeparator: ' / '
	});

	 $(".article h2 a").click(function(){  
		$(this).addClass('on');
        $(this).parent().siblings("ul").hide(); //해당 ul을 제외한 모든 ul의 형제들은 숨기기
        $(this).parent().next().show();
		$(this).parent().next().next().show();
		$(this).parent().siblings().find("a").removeClass('on');
        return false;
        
    });



});