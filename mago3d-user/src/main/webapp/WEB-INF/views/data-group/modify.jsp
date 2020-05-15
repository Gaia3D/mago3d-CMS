<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 그룹 수정 | mago3D</title>
	<link rel="shortcut icon" href="/images/favicon.ico?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cacheVersion=${contentCacheVersion}"/>
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}"/>
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css?cacheVersion=${contentCacheVersion}"/>
	<link rel="stylesheet" href="/css/${lang}/style.css?cacheVersion=${contentCacheVersion}"/>
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
					데이터 그룹 Key(영문,숫자,-,_)
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
					${dataGroup.dataGroupKey }
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					상위 그룹
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
					${dataGroup.parentName }
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
	            	<form:label path="sharing">공유 타입</form:label>
	                <span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
	            <td class="col-input">
					<select id="sharing" name="sharing" class="selectBoxClass">
						<option value="public">공개</option>
						<option value="common">공통</option>
						<option value="private">개인</option>
						<option value="group">그룹</option>
					</select>
				</td>
			</tr>
            <tr>
				<th class="col-label l" scope="row">
					기본 여부
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input radio-set">
	<c:if test="${dataGroup.basic eq 'true' }">
					기본
	</c:if>
	<c:if test="${dataGroup.basic ne 'true' }">
					선택
	</c:if>
				</td>
			</tr>
			<tr>
				<th class="col-label l" scope="row">
					사용 여부
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input radio-set">
	<c:if test="${dataGroup.basic eq 'true' }">
					사용
	</c:if>
	<c:if test="${dataGroup.basic ne 'true' }">
					<input type="radio" id="availableTrue" name="available" value="true">
					<label for="availableTrue">사용</label>
					<input type="radio" id="availableFalse" name="available" value="false">
					<label for="availableFalse">미사용</label>
	</c:if>
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
				<input type="submit" value="<spring:message code='modified'/>" onclick="updatedataGroup();"/>
				<a href="/data-group/list" class="button">목록</a>
			</div>
		</div>
		</form:form>
	</div>
	
</div>
<!-- E: WRAP -->

<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var isBasic = "${dataGroup.basic}";
		if(isBasic === "false") {
			// 기본 그룹이 아닐 경우만 사용 유무 수정 가능
			$("[name=available]").filter("[value='${dataGroup.available}']").prop("checked",true);
		}
			
		$("#sharing").val("${dataGroup.sharing}");
	});
	
	function validate() {
		var number = /^[0-9]+$/;
		if ($("#dataGroupName").val() === null || $("#dataGroupName").val() === "") {
			alert("데이터 그룹명을 입력해 주세요.");
			$("#dataGroupName").focus();
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
	
	// 수정
	var updatedataGroupFlag = true;
	function updatedataGroup() {
		if (validate() == false) {
			return false;
		}
		if(updatedataGroupFlag) {
			updatedataGroupFlag = false;
			var formData = $("#dataGroup").serialize();		
			$.ajax({
				url: "/data-groups/${dataGroup.dataGroupId}",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["update"]);
						window.location.reload();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updatedataGroupFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updatedataGroupFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 지도에서 찾기
	$( "#mapButtion" ).on( "click", function() {
		var url = "/map/find-point";
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
