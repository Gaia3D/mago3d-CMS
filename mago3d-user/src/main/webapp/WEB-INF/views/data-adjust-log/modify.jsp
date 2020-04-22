<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 Geometry 변경 요청 | NDTP</title>
	<link rel="shortcut icon" href="/images/favicon.ico?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/style.css?cacheVersion=${contentCacheVersion}" />
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
		<form:form id="dataInfo" modelAttribute="dataInfo" method="post" onsubmit="return false;">
			<form:hidden path="dataId"/>
		<table class="input-table scope-row">
			<col class="col-label l" />
			<col class="col-input" />
			<tr>
				<th class="col-label" scope="row">
					데이터 그룹명
				</th>
				<td class="col-input">
					${dataInfo.dataGroupName }
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					데이터  Key
				</th>
				<td class="col-input">
					${dataInfo.dataKey }
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					데이터명
				</th>
				<td class="col-input">
					${dataInfo.dataName }
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					소유자 아이디
				</th>
				<td class="col-input">
<c:if test="${dataInfo.dataGroupTarget eq 'admin'}">
					<span style="color: blue;">관리자</span>
</c:if>				
<c:if test="${dataInfo.dataGroupTarget eq 'user'}">
			<c:if test="${dataInfo.userId eq owner}">				
					${dataInfo.userId }
			</c:if>
			<c:if test="${dataInfo.userId ne owner}">				
					<span style="color: blue;">[다른 사용자] ${dataInfo.userId }</span>
			</c:if>
</c:if>
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
	            	공유 타입
				</th>
	            <td class="col-input">
	<c:if test="${dataInfo.sharing eq 'common'}">공통</c:if>
	<c:if test="${dataInfo.sharing eq 'public'}">공개</c:if>
	<c:if test="${dataInfo.sharing eq 'private'}">개인</c:if>
	<c:if test="${dataInfo.sharing eq 'group'}">그룹</c:if>
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
	            	매핑 타입
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
	            <td class="col-input">
	<c:if test="${dataInfo.mappingType eq 'origin'}">origin</c:if>
	<c:if test="${dataInfo.mappingType eq 'boundingboxcenter'}">boundingboxcenter</c:if>
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					<form:label path="longitude">경도/위도/높이</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</th>
				<td class="col-input">
					<form:input path="longitude" cssClass="m" />
					<form:input path="latitude" cssClass="m" />
					<form:input path="altitude" cssClass="m" />
					<input type="button" id="mapButtion" value="지도에서 찾기" />
					<form:errors path="longitude" cssClass="error" />
					<form:errors path="latitude" cssClass="error" />
					<form:errors path="altitude" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					heading/pitch/roll
				</th>
				<td class="col-input">
					<form:input path="heading" cssClass="s" />
					<form:input path="pitch" cssClass="s" />
					<form:input path="roll" cssClass="s" />
					<form:errors path="heading" cssClass="error" />
					<form:errors path="pitch" cssClass="error" />
					<form:errors path="roll" cssClass="error" />
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					메타정보
				</th>
				<td class="col-input">
					${dataInfo.metainfo }
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
	            	상태
				</th>
				<td class="col-input">
		<c:if test="${dataInfo.status eq 'processing' }">
							변환중
		</c:if>
		<c:if test="${dataInfo.status eq 'use' }">
							사용중
		</c:if>
		<c:if test="${dataInfo.status eq 'unused' }">
							사용중지
		</c:if>
		<c:if test="${dataInfo.status eq 'delete' }">
							삭제
		</c:if>		
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					속성 정보
				</th>
				<td class="col-input">
		<c:if test="${dataInfo.attributeExist eq 'true' }">	
							등록
		</c:if>
		<c:if test="${dataInfo.attributeExist eq 'false' }">
							미등록
		</c:if>
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					Object 속성 정보
				</th>
				<td class="col-input">
		<c:if test="${dataInfo.objectAttributeExist eq 'true' }">	
							등록
		</c:if>
		<c:if test="${dataInfo.objectAttributeExist eq 'false' }">
							미등록
		</c:if>
				</td>
			</tr>
			<tr>
				<th class="col-label l" scope="row">
					<spring:message code='description'/></th>
				<td class="col-input">
					${description }
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					수정일
				</th>
				<td class="col-input">
					<fmt:parseDate value="${dataInfo.updateDate}" var="viewUpdateDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${viewUpdateDate}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
			</tr>
			<tr>
				<th class="col-label" scope="row">
					등록일
				</th>
				<td class="col-input">
					<fmt:parseDate value="${dataInfo.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
			</tr>
		</table>
		<div class="button-group">
			<div class="center-buttons">
				<input type="submit" value="<spring:message code='data.transform.save.request'/>" 
						onclick="insertDataAdjustLog();"/>
				<a href="/data/list" class="button">목록</a>
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
	});
	
	function validate() {
		if ($("#longitude").val() === "") {
			alert("경도를 입력하여 주십시오.");
			$("#longitude").focus();
			return false;
		}
		if ($("#latitude").val() === "") {
			alert("위도를 입력하여 주십시오.");
			$("#latitude").focus();
			return false;
		}
		if ($("#altitude").val() === "") {
			alert("높이를 입력하여 주십시오.");
			$("#altitude").focus();
			return false;
		}
	}
	
	// 수정
	var insertDataAdjustLogFlag = true;
	function insertDataAdjustLog() {
		if (validate() == false) {
			return false;
		}
		if(insertDataAdjustLogFlag) {
			insertDataAdjustLogFlag = false;
			var formData = $("#dataInfo").serialize();		
			$.ajax({
				url: "/data-adjust-logs",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert("요청 하였습니다.");
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					insertDataAdjustLogFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertDataAdjustLogFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 지도에서 찾기 -- common.js, openFindDataPoint
	$( "#mapButtion" ).on( "click", function() {
		//openFindDataPoint("${dataInfo.dataId}", "MODIFY");
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
