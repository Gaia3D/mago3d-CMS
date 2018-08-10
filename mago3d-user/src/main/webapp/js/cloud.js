var TOGGLE_MENU_STATUS = 0;
function toggleMenu() {
	if(TOGGLE_MENU_STATUS == 0) {
		// hide
		
		// 2 logo-header
		// 3 profile-header, height = 70
		//   blank image change... 
		// 4 menu-description-header
		
		// 1 펼침 아이콘 변경
		$("#toggleMenuIcon").attr("class", "fas fa-angle-double-right");
		
		$(".logo-detail").css("display", "none");
		$(".profile-detail").css("display", "none");
		$(".left-navigation-detail").css("display", "none");
		$(".profile-header").css("height", "70px");
		//toggleMenuIcon
		
		$("#smallProfileIcons").attr("src","/images/ko/profile_example.png");
		$(".menu-description-header").css("display", "none");
		$(".sub-menu-area").css("display", "none");
		$(".content-layout").css({"margin-left" : "70px"});
		
		TOGGLE_MENU_STATUS = 1;
	} else {
		// show
		// 1 펼침 아이콘 변경
		$("#toggleMenuIcon").attr("class", "fas fa-angle-double-left");
		
		$(".logo-detail").css("display", "");
		$(".profile-detail").css("display", "");
		$(".left-navigation-detail").css("display", "");  
		//$("#contentArea").css({"margin-left" : "70px"});	
		
		$(".profile-header").css("height", "120px");
		$("#smallProfileIcons").attr("src","/images/1px.png");
		$(".menu-description-header").css("display", "");
		$(".sub-menu-area").css("display", "");
		$(".content-layout").css({"margin-left" : "220px"});
		TOGGLE_MENU_STATUS = 0;
	}
}