// 삭제 처리 경고
function deleteWarning() {
	if(confirm(JS_MESSAGE["delete.confirm"])) {
		return true;
	} else {
		return false;
	}
}

// 로딩중 Spinner 처리
function startSpinner(loadingId) {
	var $spinnerDiv = $("#" + loadingId);
    var $spinner = $spinnerDiv.progressSpin({ activeColor: "white", fillColor:"green" });
    $spinner.start();
}

//로딩 시작
function startLoading() {
	$('#loadingWrap').show();
}
//로딩 중지
function stopLoading() {
	$('#loadingWrap').hide();
}

// 팝업
function popupOpen(url, title, width, height) {
	var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height 
			+ ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
	popWin.document.title = title;
}

//숫자체크
function isNumber(control) {
	var val = control;
	var Num = "1234567890";
	for (var i=0; i<val.length; i++) {
		if(Num.indexOf(val.substring(i,i+1))<0) {
			alert(JS_MESSAGE["number.constraint"]);
			return false;
		}
	}
	return true;
}

// IP 체크
var ipRegularExpression = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;
function isIP(ipAddress) {
	if (ipAddress == null || ipAddress == "" || !ipRegularExpression.test(ipAddress)) {
		return false;
	}
	return true;
}

// 엑셀 파일 체크
function isExcelFile(fileName) {
	if(fileName.lastIndexOf("xlsx") >0 || fileName.lastIndexOf("xls") >0) {
		return true;
	} else {
		return false;
	}
}

// 선택된 checkbox 가 있으면 true, 없으면 false
function checkedStatus(element) {
	var returnVal = true;
	var checkStatusVal = 0;
	$.each(element, function(index) {			
		if (element[index].checked == true) {
			checkStatusVal++;
		}
	});
	//console.log("@@@@@@@@@@@@@@@@@ checkStatusVal = " + checkStatusVal);
	if (checkStatusVal == 0) {
		returnVal = false;
	}		
	return returnVal; 
}

function initDatePicker() {
	$( ".date" ).datepicker({ 
		dateFormat : "yymmdd",
		dayNames : [ "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT" ],
		dayNamesShort : [ "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT" ],
		dayNamesMin : [ "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT" ],
		monthNames : [ "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SET", "OCT", "NOV", "DEC" ],
		monthNamesShort : [ "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SET", "OCT", "NOV", "DEC" ],
		prevText : "",
		nextText : "",
		showMonthAfterYear : true,
		yearSuffix : "Year"
	});
}

// Select Box 초기화
function initSelect(idArray, valueArray) {
	for(var i=0; i<idArray.length; i++) {
		if(valueArray[i] != null && valueArray[i] != "") {
			//console.log(idArray[i] + ", " + valueArray[i]);
			$("#" + idArray[i]).val(valueArray[i]);
		}
	}
}

// Radio 버튼 초기화
function initRadio(nameArray, valueArray) {
	for(var i=0; i<nameArray.length; i++) {
		if(valueArray[i] != null && valueArray[i] != "") {
			$("[name=" + nameArray[i] + "]").filter("[value=" + valueArray[i] + "]").prop("checked",true);
		}
	}
}

// CheckBox 초기화
function initCheckBox(idArray, valueArray) {
	for(var i=0; i<idArray.length; i++) {
		if(valueArray[i] != null && valueArray[i] != "") {
			$("#" + idArray[i]).prop("checked", true);
		}
	}
}

// Calendar 초기화
function initCalendar(idArray, valueArray) {
	for(var i=0; i<idArray.length; i++) {
		$("#" + idArray[i]).datepicker( { dateFormat: 'yymmdd' } );
		if(valueArray[i] != null && valueArray[i] != "") {
			$("#" + idArray[i]).val(valueArray[i].substring(0,8));
		}
	}
}

//팝업창인지 체크하여 팝업창일시 사이즈조절. 팝업창을 가운데로 위치시킴.
function isPopChk() {
	if(opener != undefined) {
		var popWidth = document.body.scrollWidth + 10;
		var popHeight = document.body.scrollHeight + 35;

		self.moveTo(screen.width/2-(popWidth/2),screen.height/2-(popHeight/2));
		self.resizeTo(popWidth , popHeight);
	}
}

function popup(url, title, width, height, scroll) {
	var xPos = (window.screen.availWidth - width)/2;
	var yPos = (window.screen.availHeight - height)/2;

	win = window.open(url,title,'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars='+scroll+',toolbar=no,resizable=no,copyhistory=no,width='+width+',height='+height+',left='+ xPos +',top='+ yPos+'\'');
	win.focus();
}

function drawPage(pagination, jobtype, areaId) {
	var pagecontent = "";
	var pageIndex = null;
	if(pagination.totalCount > 0) {
		pagecontent +=			"<a href=\"#\" class=\"first\" onclick=\"drawGroupPage('" + pagination.startPage + "', '" + jobtype + "'); return false;\"><span class=\"icon-glyph glyph-first\"></span></a>";
		if(pagination.existPrePage == true) {
			pagecontent +=		"<a href=\"#\" class=\"prev\" onclick=\"drawGroupPage('" + pagination.prePageNo + "', '" + jobtype + "'); return false;\"><span class=\"icon-glyph glyph-prev\"></span></a>";
		}
		for(var pageIndex = pagination.startPage; pageIndex <= pagination.endPage; pageIndex++) {
			if(pageIndex == pagination.pageNo) {
				pagecontent +=	"<a href=\"#\" class=\"current-page\">" + pageIndex + "</a>";
			} else {
				pagecontent +=	"<a href=\"#\" onclick=\"drawGroupPage('" + pageIndex + "', '" + jobtype + "'); return false;\">" + pageIndex + "</a>";
			}
		}
		if(pagination.existNextPage == true) {
			pagecontent +=		"<a href=\"#\" class=\"next\" onclick=\"drawGroupPage('" + pagination.nextPageNo + "', '" + jobtype + "'); return false;\"><span class=\"icon-glyph glyph-next\"></span></a>";
		}
		pagecontent +=			"<a href=\"#\" class=\"last\" onclick=\"drawGroupPage('" + pagination.lastPage + "', '" + jobtype + "'); return false;\"><span class=\"icon-glyph glyph-last\"></span></a>";
	}
	
	$("#" + areaId).empty();
	$("#" + areaId).html(pagecontent);
}

/**
 * 동일 문자 연속 입력 검증 (111, aaa)
 */
function isContinueSameChar(input){
	var result = false;
   
//         result = /(\w)\1\1/.test(input);
   
	for(var i=0; i < input.length; i++){
		tmp = input.charAt(i);
		if(tmp == input.charAt(i+1) && tmp == input.charAt(i+2)){                                    
			result = true;
		}
		
	}
	
	return result;
 }
 
/**
 * 연속되는 문자 입력 검증 (123, abc)
 */
function isSequenceChar(input){
	var result = false;
	
	for(var i=0; i <  input.length; i++){
		
		tmp = input.charCodeAt(i);
		
		if(input.charCodeAt(i + 1) - tmp == 1 && input.charCodeAt(i + 2) - input.charCodeAt(i + 1) == 1){
			result = true;
		}                              
		
	}

	return result;             
}

function changeLanguage(lang) {
	var updateFlag = true;
	if(updateFlag) {
		updateFlag = false;
		$.ajax({
			url: "/sign/change-language?lang=" + lang,
			type: "GET",
			//data: info,
			cache: false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					//alert(JS_MESSAGE["success"]);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
				updateFlag = true;
			},
			error:function(request,status,error){
		        //alert(JS_MESSAGE["ajax.error.message"]);
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        updateFlag = true;
			}
		});
	} else {
		alert(JS_MESSAGE["button.dobule.click"]);
		return;
	}
}

//한글인지 검사
function isHangul(value) {
	var pattern_kor = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	if( pattern_kor.test(value) ) {
		return true
	} else {
		return false
	}
}

// 경도 체크
function isLongitude(value) {
	var regexLongitude = /^[-+]?(180(\.0{0,6})?|((1[0-7]\d)|([1-9]?\d))(\.\d{0,8})?)$/;
	return regexLongitude.test(value) ? true : false;
}

// 위도 체크
function isLatitude(value) {
	var regexLatitude = /^[-+]?([0-8]?\d(\.\d{0,6})?|90(\.0{0,8})?)$/;
	return regexLatitude.test(value) ? true : false;
}

// 세자리 콤마
function formatNumber(value) {
	return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function notyetAlram() {
	alert('아직 준비중입니다.');
}

//hex color to rgb string
function hex2rgb(hex) {
	hex = hexToDoubleHex(hex);
	
	var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
	return result ? 'rgba(' +
	    parseInt(result[1], 16) + ', ' +
	    parseInt(result[2], 16) + ', ' +
	    parseInt(result[3], 16) + ')' :
	    'rgba(255, 255, 255)';
};
//hex color to rgb array
function hex2rgbArray(hex) {
	hex = hexToDoubleHex(hex);
	
	var regResult = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
	var splitHex = regResult.slice(1,4);
	var result = splitHex.map(function(e){return parseInt(e,16)});
	return result;
};
//#000 -> #000000 함수명이 좀 이상함... 글자 세개랑 글자 6개에 대한 명칭을 잘 모르겟음 
function hexToDoubleHex (hex){
	var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
	hex = hex.replace(shorthandRegex, function (m, r, g, b) {
	    return r + r + g + g + b + b;
	});
	
	return hex;
}

// 지도에서 찾기 팝업창
function openFindDataPoint(dataId, referrer) {
	var url = "/map/find-data-point?dataId=" + dataId + "&referrer=" + referrer;
	var width = 1200;
	var height = 740;

	var popupX = (window.screen.width / 2) - (width / 2);
	// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= (window.screen.height / 2) - (height / 2);

    var popWin = window.open(url, "","toolbar=no, width=" + width + ", height=" + height + ", top=" + popupY 
    		+ ", left=" + popupX + ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
    //popWin.document.title = layerName;
};

// 세슘 크레딧 이미지 alt추가(웹 접근성)
function cesiumCreditAlt(){
	var magoContiner = document.getElementsByClassName("cesium-credit-logoContainer")[0];
	var creditImgTag = magoContiner.getElementsByTagName("img")[0];
	creditImgTag.setAttribute( 'alt', 'cesium credit' );
};

//init policy
function initPolicy(callback, dataId) {
	if(!dataId) dataId = "";
	$.ajax({
		url: "/geopolicies/user?dataId="+dataId,
		type: "GET",
		headers: {"X-Requested-With": "XMLHttpRequest"},
		dataType: "json",
		success: function(msg){
			if(msg.statusCode <= 200) {
				callback(msg.geoPolicy, msg.baseLayers);
			} else {
				alert(JS_MESSAGE[msg.errorCode]);
			}
		},
		error:function(request,status,error){
			alert(JS_MESSAGE["ajax.error.message"]);
		}
	});
}

/**
 * 경위도 유효 범위 체크 
 * @param longitude
 * @param latitude
 * @param altitude
 * @returns
 */
function locationValidation(longitude, latitude, altitude) {
	var lon = Number(longitude);
	var lat = Number(latitude);
	var alt = Number(altitude);
	if(isNaN(lon) || isNaN(lat) || isNaN(alt)) {
		alert(JS_MESSAGE["number.constraint"]);
		return false;
	}
	if((-180 <= lon && lon <= 180) &&  (-90 <= lat && lat <= 90) && (-100 <= alt && alt <= 300000)) {
		return true;
	} else {
		alert(JS_MESSAGE["location.constraint"]);
		return false;
	}
}
