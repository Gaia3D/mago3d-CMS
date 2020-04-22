<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>업로딩 데이터 수정 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
    <script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
</head>

<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>

	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="uploadData" modelAttribute="uploadData" method="post" onsubmit="return false;">
							<form:hidden path="uploadDataId" />
							<table class="input-table scope-row" summary="업로드 데이터 수정">
							<caption class="hiddenTag">업로드 데이터 수정</caption>
								<colgroup>
									<col class="col-label l" style="width: 13%" >
									<col class="col-input" style="width: 37%" >
									<col class="col-label l" style="width: 13%" >
									<col class="col-input" style="width: 37%" >
					            </colgroup>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="dataName">데이터명</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="dataName" class="l" />
					 						<form:errors path="dataName" cssClass="error" />
									</td>
									<th class="col-label" scope="row">
										<form:label path="dataGroupName">데이터 그룹</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:hidden path="dataGroupId" />
											<form:input path="dataGroupName" cssClass="m" readonly="true" />
										<input type="button" id="dataGroupButtion" value="데이터 그룹 선택" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
					                	<form:label path="sharing">공유 유형</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<select id="sharing" name="sharing" class="selectBoxClass">
											<option value="public">공개</option>
											<option value="common">공통</option>
											<option value="private">비공개</option>
											<option value="group">그룹 공개</option>
										</select>
									</td>
									<th class="col-label m" scope="row">
										<form:label path="dataType">데이터 타입</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<select id="dataType" name="dataType" class="selectBoxClass">
											<option value="citygml" selected="selected"> CITYGML </option>
											<option value="indoorgml"> INDOORGML </option>
											<option value="ifc"> IFC </option>
											<option value="las"> LAS(POINT CLOUD) </option>
											<option value="3ds"> 3DS </option>
											<option value="obj"> OBJ </option>
							          		<option value="dae"> COLLADA(DAE) </option>
										</select>
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="longitude">대표 위치 (경도/위도/높이) </form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="longitude" cssClass="m" placeholder="longitude" />
										<form:input path="latitude" cssClass="m" placeholder="latitude" />
										<form:input path="altitude" cssClass="m" placeholder="altitude" />
										<input type="button" id="mapButtion" value="지도" />
										<form:errors path="longitude" cssClass="error" />
										<form:errors path="latitude" cssClass="error" />
										<form:errors path="altitude" cssClass="error" />
									</td>
									<th class="col-label m" scope="row">
										<form:label path="mappingType">매핑 타입</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<select id="mappingType" name="mappingType" class="selectBoxClass">
											<option value="origin" selected="selected"> ORIGIN </option>
											<option value="boundingboxcenter"> BOUNDING BOX CENTER </option>
										</select>
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="description"><spring:message code='description'/></form:label>
									</th>
									<td colspan="3" class="col-input">
										<form:input path="description" class="xl" />
					 					<form:errors path="description" cssClass="error" />
									</td>
								</tr>
							</table>
							<div class="button-group">
								<div class="center-buttons">
									<button id="updateButton">수정</button>
									<a href="/upload-data/list" class="button">목록</a>
								</div>
							</div>

							<table class="input-table scope-row">
								<colgroup>
					                   <col class="col-label l" style="width: 15%" >
					                   <col class="col-input" style="width: 35%" >
					                   <col class="col-label l" style="width: 15%" >
					                   <col class="col-input" style="width: 35%" >
					               </colgroup>
								<tr>
									<th class="col-label" scope="row" style="vertical-align: top;">
										<form:label path="description">첨부 파일</form:label>
									</th>
									<td colspan="3" class="col-input">
										<ul style="list-style: none; margin-bottom: 20px;">

<c:set var="converterFileStyle" value="" />
<c:forEach var="uploadDataFile" items="${uploadDataFileList}" varStatus="status">
	<c:if test="${uploadDataFile.depth == 1 }">
		<c:set var="paddingLeft" value="0px;" />
	</c:if>
	<c:if test="${uploadDataFile.depth == 2 }">
		<c:set var="paddingLeft" value="50px;" />
	</c:if>
	<c:if test="${uploadDataFile.depth == 3 }">
		<c:set var="paddingLeft" value="100px;" />
	</c:if>
	<c:if test="${uploadDataFile.depth == 4 }">
		<c:set var="paddingLeft" value="150px" />
	</c:if>

	<c:if test="${uploadDataFile.fileType eq 'DIRECTORY' }">
											<li style="padding-left: ${paddingLeft}; height: 25px;">[ ${uploadDataFile.fileType } ] ${uploadDataFile.fileSubPath }</li>
	</c:if>
	<c:if test="${uploadDataFile.converterTarget eq 'true' }">
		<c:set var="converterFileStyle" value="color:blue; font-weight: bold;" />
	</c:if>
	<c:if test="${uploadDataFile.converterTarget eq 'false' }">
		<c:set var="converterFileStyle" value="" />
	</c:if>

	<c:if test="${uploadDataFile.fileType eq 'FILE' }">
											<li style="padding-left: ${paddingLeft}; height: 25px; ${converterFileStyle}">
												[ ${uploadDataFile.fileType } ] ${uploadDataFile.fileName }
												(<fmt:formatNumber value="${uploadDataFile.viewFileSizeUnitKB }" type="number"/>)KB
											</li>
	</c:if>
</c:forEach>
										</ul>
									</td>
								</tr>
							</table>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<!-- E: WRAP -->
<%@ include file="/WEB-INF/views/upload-data/data-group-dialog.jsp" %>

<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#sharing").val("${uploadData.sharing}");
		$("#dataType").val("${uploadData.dataType}");
		$("#mappingType").val("${uploadData.mappingType}");
	});

	var dataGroupDialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 500,
		width: 1000,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 상위 Layer Group 찾기
	$( "#dataGroupButtion" ).on( "click", function() {
		dataGroupDialog.dialog( "open" );
		dataGroupDialog.dialog( "option", "title", "데이터 그룹 선택");
	});

	// 데이터 그룹 선택
	function confirmDataGroup(dataGroupId, dataGroupName) {
		$("#dataGroupId").val(dataGroupId);
		$("#dataGroupName").val(dataGroupName);
		dataGroupDialog.dialog( "close" );
	}

	function validate() {
		if ($("#dataName").val() === "") {
			alert("데이터명을 입력하여 주십시오.");
			$("#dataName").focus();
			return false;
		}
		if ($("#longitude").val() === "") {
			alert("대표 위치(경도)를 입력하여 주십시오.");
			$("#longitude").focus();
			return false;
		}
		if ($("#latitude").val() === "") {
			alert("대표 위치(위도)를 입력하여 주십시오.");
			$("#latitude").focus();
			return false;
		}
		if ($("#altitude").val() === "") {
			alert("대표 위치(높이)를 입력하여 주십시오.");
			$("#altitude").focus();
			return false;
		}
		if(!locationValidation($("#longitude").val(), $("#latitude").val(), $("#altitude").val())) {
			return false;
		}
	}

	// 수정
	var updateFlag = true;
	$( "#updateButton" ).on( "click", function() {
		if (validate() == false) {
			return false;
		}
		if(updateFlag) {
			updateFlag = false;
			var formData = $("#uploadData").serialize();
			$.ajax({
				url: "/upload-datas/${uploadData.uploadDataId}",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updateFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});

	//지도에서 찾기
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
