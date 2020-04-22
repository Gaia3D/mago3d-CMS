<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 그룹 등록 | NDTP</title>
	<link rel="shortcut icon" href="/images/favicon.ico?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}"/>
	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
</head>
<body>

<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap">
	<!-- S: NAVWRAP -->
	<div class="navWrap">
	 	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	</div>
	<!-- E: NAVWRAP -->

	<div class="container" style="float:left; width: calc(100% - 78px);">
		<div style="padding: 20px 20px 0px 10px; font-size: 18px;">3D 업로딩 데이터 자동 변환</div>
		<div class="tabs" >
			<ul class="tab">
				<li id="tabDataGroupList"><a href="/data-group/list">데이터 그룹</a></li>
				<li id="tabDataGroupInput"><a href="/data-group/input">데이터 그룹 등록</a></li>
				<li id="tabUploadDataInput"><a href="/upload-data/input">업로딩 데이터</a></li>
			   	<li id="tabUploadDataList"><a href="/upload-data/list">업로딩 데이터 목록</a></li>
			  	<li id="tabConverterList"><a href="/converter/list">업로딩 데이터 변환 목록</a></li>
			  	<li id="tabDataList"><a href="/data/list">데이터 목록</a></li>
			  	<li id="tabDataLogList"><a href="/data-log/list">데이터 변경 이력</a></li>
			</ul>
		</div>
		<form:form id="dataGroup" modelAttribute="dataGroup" method="post" onsubmit="return false;">
		<table class="input-table scope-row">
			<col class="col-label l" />
			<col class="col-input" />
			<tr>
				<th class="col-label" scope="row">
					<form:label path="dataGroupName">데이터 그룹명</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
					<form:input path="dataGroupName" cssClass="l" maxlength="100" />
					<form:errors path="dataGroupName" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="dataGroupKey">데이터 그룹 Key(영문,숫자,-,_)</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
					<form:hidden path="duplication"/>
					<form:input path="dataGroupKey" cssClass="l" />
					<input type="button" id="duplicationButtion" value="<spring:message code='overlap.check'/>" />
					<form:errors path="dataGroupKey" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="parentName">상위 데이터 그룹</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
					<form:hidden path="parent" />
					<form:input path="parentName" cssClass="l" readonly="true" />
					<input type="button" id="dataGroupButtion" value="상위 데이터 그룹 선택" />
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
                	<form:label path="sharing">공유 타입</form:label>
                    <span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
                	<select id="sharing" name="sharing" class="selectBoxClass">
						<option value="public" selected="selected">공개</option>
						<option value="common">공통</option>
						<option value="private">개인</option>
						<option value="group">그룹</option>
					</select>
				</td>
			</tr>
			<!-- <tr>
				<th class="col-label l" scope="row">
					기본 여부
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input radio-set">
					<input type="radio" id="basicTrue" name="basic" value="true" >
					<label for="basicTrue">기본</label>
					<input type="radio" id="basicFalse" name="basic" value="false" checked >
					<label for="basicFalse">선택</label>
				</td>
			</tr> -->
			<tr>
				<th class="col-label l" scope="row">
					사용 여부
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input radio-set">
					<input type="radio" id="availableTrue" name="available" value="true" checked>
					<label for="availableTrue">사용</label>
					<input type="radio" id="availableFalse" name="available" value="false">
					<label for="availableFalse">미사용</label>
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="longitude">경도</form:label>
				</th>
				<td class="col-input">
					<form:input path="longitude" cssClass="m" />
					<input type="button" id="mapButtion" value="지도에서 찾기" />
					<form:errors path="longitude" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="latitude">위도</form:label>
				</th>
				<td class="col-input">
					<form:input path="latitude" cssClass="m" />
					<form:errors path="latitude" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="altitude">높이</form:label>
				</th>
				<td class="col-input">
					<form:input path="altitude" cssClass="m" />
					<form:errors path="altitude" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="duration">이동시간</form:label>
				</th>
				<td class="col-input">
					<form:input path="duration" cssClass="s" />&nbsp;&nbsp;ms
					<form:errors path="duration" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="metainfo">메타정보</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
					<form:input path="metainfo" class="xl" value="{\"isPhysical\": false}" />
 						<form:errors path="metainfo" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th class="col-label l" scope="row"><form:label path="description"><spring:message code='description'/></form:label></th>
				<td class="col-input"><form:input path="description" cssClass="xl" /></td>
			</tr>
		</table>
		<div class="button-group">
			<div class="center-buttons">
				<input type="submit" value="<spring:message code='save'/>" onclick="insertDataGroup();"/>
				<a href="/data-group/list" class="button">목록</a>
			</div>
		</div>
		</form:form>
	</div>

</div>
<!-- E: WRAP -->

<!-- 상위 그룹 선택 다이얼 로그 -->
<%@ include file="/WEB-INF/views/data-group/parent-data-group-dialog.jsp" %>

<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});

	// 입력값이 변경되면 중복체크, 영문+숫자
	/* $("#dataGroupKey").on("keyup", function(event) {
		$("#duplication").val(null);
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputValue = $(this).val();
			$(this).val(inputValue.replace(/[^a-z0-9]/gi,''));
		}
	}); */
	
	// 데이터 그룹 중복 확인
	$( "#duplicationButtion" ).on( "click", function() {
		var dataGroupKey = $("#dataGroupKey").val();
		if (dataGroupKey == "") {
			alert("데이터 그룹키(한글불가)를 입력해 주세요.");
			$("#dataGroupKey").focus();
			return false;
		}
		
		var regDataGroupKey = /^[a-zA-Z0-9-_]+$/;
		if (!regDataGroupKey.test(document.getElementById("dataGroupKey").value)) {
			alert("데이터 그룹키(한글불가)가 올바르지 않습니다.");
			return false;
		}
		
		var formData = "dataGroupKey=" + dataGroupKey;
		$.ajax({
			url: "/data-groups/duplication",
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
	        data: formData,
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.duplication == true) {
						alert(JS_MESSAGE["data.group.key.duplication"]);
						$("#dataGroupKey").focus();
						return false;
					} else {
						alert(JS_MESSAGE["data.group.key.enable"]);
						$("#duplication").val(msg.duplication);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
			},
			error:function(request, status, error) {
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	});

	function validate() {
		var number = /^[0-9]+$/;
		if ($("#dataGroupName").val() === null || $("#dataGroupName").val() === "") {
			alert("데이터 그룹명을 입력해 주세요.");
			$("#dataGroupName").focus();
			return false;
		}
		if($("#duplication").val() === null || $("#duplication").val() === "") {
			alert(JS_MESSAGE["data.group.key.duplication.check"]);
			$("#dataGroupKey").focus();
			return false;
		} else if($("#duplication").val() === "true") {
			alert(JS_MESSAGE["data.group.key.duplication"]);
			$("#dataGroupKey").focus();
			return false;
		}
		if ($("#dataGroupKey").val() === null || $("#dataGroupKey").val() === "") {
			alert("데이터 그룹키(한글불가)를 입력해 주세요.");
			$("#dataGroupKey").focus();
			return false;
		}
		if($("#parent").val() === null || $("#parent").val() === "" || !number.test($("#parent").val())) {
			alert("상위 데이터 그룹을 선택해 주세요.");
			$("#parent").focus();
			return false;
		}
		if($("#duration").val() !== null && $("#duration").val() !== "") {
			if(!isNumber($("#duration").val())) {
				$("#duration").focus();
				return false;
			}
		}
		if(!locationValidation($("#longitude").val(), $("#latitude").val(), $("#altitude").val())) {
			return false;
		}
	}

	// 저장
	var insertDataGroupFlag = true;
	function insertDataGroup() {
		if (validate() == false) {
			return false;
		}
		if(insertDataGroupFlag) {
			insertDataGroupFlag = false;
			var formData = $("#dataGroup").serialize();
			$.ajax({
				url: "/data-groups",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["insert"]);
						window.location.reload();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					insertDataGroupFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertDataGroupFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	var dataGroupDialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 500,
		width: 1000,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 상위 데이터 그룹 찾기
	$( "#dataGroupButtion" ).on( "click", function() {
		dataGroupDialog.dialog( "open" );
		dataGroupDialog.dialog( "option", "title", "데이터 그룹 선택");
	});

	// 다이얼로그에서 선택
	function confirmParent(parent, parentName, parentDepth) {
		if(parentDepth >= 3) {
			alert("사용자 데이터 그룹은 3Depth 이상 계층으로 입력할 수 없습니다.");
			return;
		}
		$("#parent").val(parent);
		$("#parentName").val(parentName);
		dataGroupDialog.dialog( "close" );
	}

	$( "#rootParentSelect" ).on( "click", function() {
		$("#parent").val(0);
		$("#parentName").val("${dataGroup.parentName}");
		dataGroupDialog.dialog( "close" );
	});

	// 지도에서 찾기
	$( "#mapButtion" ).on( "click", function() {
		var url = "/map/find-point?referrer=data-group-input";
		var width = 800;
		var height = 700;

		var popupX = (window.screen.width / 2) - (width / 2);
		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupY= (window.screen.height / 2) - (height / 2);

	    var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height + ", top=" + popupY + ", left="+popupX
	            + ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
	    //popWin.document.title = layerName;
	});
</script>
</body>
</html>
