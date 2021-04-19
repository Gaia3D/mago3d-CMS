// 검색어 enter
$("#fullTextSearch").keyup(function(e) {
	if(e.keyCode == 13) {
		if(fullTextSearchCheck()) {
			fullTextSearch();
		}
	}
});

// 검색 버튼을 눌렀을때
$("#fullTextSearchButton").click(function() {
	if(fullTextSearchCheck()) {
		fullTextSearch();
	}
});
// 닫기 버튼 클릭
$('#districtSearchCloseButton').click(function() {
	$('#districtSearchResultContent').hide();
});
// 지도 클릭
$('#magoContainer').click(function(e) {
	if ($("#districtSearchResultContent").is(':visible')) {
		$("#districtSearchResultContent").hide();
	}
});
// 입력 체크
function fullTextSearchCheck() {
	if($("#fullTextSearch").val() === null || $("#fullTextSearch").val().trim() === "") {
		alert(JS_MESSAGE["search.enter.word"]);
		$("#fullTextSearch").focus();
		return false;
	}
	if($("#fullTextSearch").val().trim().length === 1) {
		alert(JS_MESSAGE["search.required.word"]);
		$("#fullTextSearch").focus();
		return false;
	}
	if ($("#districtSelectContent").is(':visible')) {
		$("#districtSelectContent").hide();
	}
	return true;
}

var fullTextSearchFlag = true;
function fullTextSearch() {
	if(fullTextSearchFlag) {
		fullTextSearchFlag = false;
		//if($('#searchContent').css("display") ==='none') $(".search").click();
		districtSearch(null);
	} else {
		alert(JS_MESSAGE["searching"]);
		return;
	}
}

// 검색창 클릭시 메뉴 제어
function showSearchMenu() {
	$("#searchMenu").toggleClass("on");
	$('#searchContent').toggle(true);
	$('#contentsWrap').toggle(true);
//	$("#newAddressSearchList").height(200);
}

// 행정구역 검색
function districtSearch(pageNo) {
	event.stopPropagation();
	var info = "fullTextSearch=" + $("#fullTextSearch").val();;
	info += "&searchKey=newAddress";
	if(pageNo !== null) {
		info = info + "&pageNo=" + pageNo;
	}
	$.ajax({
		url: "../searchmap/district",
		type: "GET",
		data: info,
		dataType: "json",
		success: function(msg){
			if(msg.statusCode <= 200) {
				msg.pagination.pageList = [];
				var start = msg.pagination.startPage;
				var end = msg.pagination.endPage;
				for(i = start; i <= end; i++) {
					msg.pagination.pageList.push(i);
				}
				//핸들바 템플릿 컴파일
				var template = Handlebars.compile($("#districtSearchResultSource").html());
				var pageTemplate = Handlebars.compile($("#districtPaginationSource").html());
				$("#districtSearchResultDHTML").html("").append(template(msg))
				$("#districtPaginationDHTML").html("").append(pageTemplate(msg));
				$('#districtSearchResultContent').show();
				fullTextSearchFlag = true;
			} else {
				alert(JS_MESSAGE[msg.errorCode]);
				console.log("---- " + msg.message);
			}
		},
		error:function(request,status,error) {
			//console.log(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
			console.log("new address error .....  searchTypeCount = " + searchTypeCount);
		}
	});
}

