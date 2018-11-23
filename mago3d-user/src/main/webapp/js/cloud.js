var TOGGLE_MENU_STATUS = 0;

function toggleMenu() {
	console.log("click......");
	$("#site-content").toggleClass("on");
	if(TOGGLE_MENU_STATUS == 0) {
		// hide
		$("#smallUserProfileImage").attr("src","/images/ko/profile_example.png");
		$("#smallUserProfileImage").attr("width","50px");
		$("#smallUserProfileImage").attr("height","50px");
		
		// 메뉴 아이콘 작게
		$(".profile-menu").css("height", "70px");
		$(".project-menu").css("height", "70px");
		$(".converter-menu").css("height", "70px");
		$(".settings-menu").css("height", "70px");
		
		TOGGLE_MENU_STATUS = 1;
	} else {
		// show
		$("#smallUserProfileImage").attr("src","/images/1px.png");
		
		$(".profile-menu").css("height", "110px");
		$(".project-menu").css("height", "190px");
		$(".converter-menu").css("height", "150px");
		$(".settings-menu").css("height", "100px");
		
		// 메뉴 아이콘 원복
		TOGGLE_MENU_STATUS = 0;
	}
		
	/*<img id="smallProfileIcons" src="/images/1px.png" style="width: 50px; height: 80px;">*/
}

/*$( "#toggleMenuIcon" ).on( "click", function() {
	console.log("click......");
	$("#site-content").toggleClass("on");
});*/

/*function toggleMenu() {
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
}*/

// project view type
$( function() {
	$( ".project-view-radio" ).checkboxradio({
		icon: false
	});
	
	var currentPathName = location.pathname;
	if(currentPathName.indexOf("map-project") >= 0) {
		$( "#project_view_map" ).prop( "checked", true ).checkboxradio( "refresh" );
	} else {
		$( "#project_view_table" ).prop( "checked", true ).checkboxradio( "refresh" );
	}
		
	$('#project_view_map').click(function () {
		location.href="/project/map-project.do";
		return;
	});
	$('#project_view_table').click(function () {
		location.href="/project/list-project.do";
		return;
	});
});