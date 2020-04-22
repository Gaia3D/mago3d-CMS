<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>업로딩 데이터 변환 목록 | NDTP</title>
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
		<div class="filters">
			<form:form id="searchForm" modelAttribute="converterJob" method="get" action="/converter/list" onsubmit="return searchCheck();">
			<div class="input-group row">
				<div class="input-set">
					<label for="searchWord"><spring:message code='search.word'/></label>
					<select id="searchWord" name="searchWord" class="selectBoxClass">
						<option value=""><spring:message code='select'/></option>
	          			<option value="title">제목</option>
					</select>
					<select id="searchOption" name="searchOption" class="selectBoxClass">
						<option value="0"><spring:message code='search.same'/></option>
						<option value="1"><spring:message code='search.include'/></option>
					</select>
					<form:input path="searchValue" type="search" cssClass="m" cssStyle="float: right;" />
				</div>
				<div class="input-set">
					<label for="startDate"><spring:message code='search.date'/></label>
					<input type="text" class="s date" id="startDate" name="startDate" autocomplete="off" />
					<span class="delimeter tilde">~</span>
					<input type="text" class="s date" id="endDate" name="endDate" autocomplete="off" />
				</div>
				<div class="input-set">
					<label for="orderWord"><spring:message code='search.order'/></label>
					<select id="orderWord" name="orderWord" class="selectBoxClass">
						<option value=""> <spring:message code='search.basic'/> </option>
						<option value="title">제목</option>
						<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
					</select>
					<select id="orderValue" name="orderValue" class="selectBoxClass">
                		<option value=""> <spring:message code='search.basic'/> </option>
	                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
						<option value="DESC"> <spring:message code='search.descending.order'/> </option>
					</select>
					<select id="listCounter" name="listCounter" class="selectBoxClass">
                		<option value="10"> <spring:message code='search.ten.count'/> </option>
	                	<option value="50"> <spring:message code='search.fifty.count'/> </option>
						<option value="100"> <spring:message code='search.hundred.count'/> </option>
					</select>
				</div>
				<div class="input-set">
					<input type="submit" value="<spring:message code='search'/>" />
				</div>
			</div>
			</form:form>
		</div>

		<div class="list">
			<form:form id="listForm" modelAttribute="converterJob" method="post">
				<input type="hidden" id="checkIds" name="checkIds" value="" />
			<div class="list-header row">
				<div class="list-desc u-pull-left">
					<spring:message code='all.d'/> <span class="totalCount"><fmt:formatNumber value="${pagination.totalCount}" type="number"/></span> <spring:message code='search.what.count'/>,
					<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
				</div>
			</div>
			<table class="list-table scope-col">
				<col class="col-number" />
				<col class="col-name" />
				<col class="col-name" />
				<col class="col-number" />
				<col class="col-name" />
				<col class="col-type" />
				<col class="col-number" />
				<col class="col-functions" />
				<col class="col-functions" />
				<thead>
					<tr>
						<th scope="col" class="col-number"><spring:message code='number'/></th>
						<th scope="col" class="col-name">변환 유형</th>
						<th scope="col" class="col-name">제목</th>
						<th scope="col" class="col-name">U.S.F</th>
						<th scope="col" class="col-name">높이방향</th>
						<th scope="col" class="col-name">상태</th>
						<th scope="col" class="col-name">파일 개수</th>
						<th scope="col" class="col-name">에러코드</th>
						<th scope="col" class="col-date">등록일</th>
					</tr>
				</thead>
				<tbody>
<c:if test="${empty converterJobList }">
					<tr>
						<td colspan="9" class="col-none">Converter Job이 존재하지 않습니다.</td>
					</tr>
</c:if>
<c:if test="${!empty converterJobList }">
<c:forEach var="converterJob" items="${converterJobList}" varStatus="status">

					<tr>
						<td class="col-number">${pagination.rowNumber - status.index }</td>
						<td class="col-type">
<c:if test="${converterJob.converterTemplate eq 'basic'}">기본</c:if>
<c:if test="${converterJob.converterTemplate eq 'building'}">빌딩</c:if>
<c:if test="${converterJob.converterTemplate eq 'extra-big-building'}">초대형 빌딩</c:if>
<c:if test="${converterJob.converterTemplate eq 'point-cloud'}">point cloud</c:if>
						</td>
						<td class="col-name ellipsis" style="min-width:200px;max-width:200px;">${converterJob.title }</td>
						<td class="col-count"><fmt:formatNumber value="${converterJob.usf}" type="number"/>
<c:if test="${converterJob.usf ge 1 and converterJob.usf lt 10}"> m</c:if>
<c:if test="${converterJob.usf ge 0.1 and converterJob.usf lt 1 }"> cm</c:if>
<c:if test="${converterJob.usf ge 0.01 and converterJob.usf lt 0.1}"> cm</c:if>
<c:if test="${converterJob.usf ge 0.001 and converterJob.usf lt 0.01}"> mm</c:if>
<c:if test="${converterJob.usf ge 10}"> m</c:if>
						</td>
						<td class="col-type">
<c:if test="${converterJob.viewYAxisUp eq 'N'}">Z축</c:if>
<c:if test="${converterJob.viewYAxisUp eq 'Y'}">Y축</c:if>
						</td>
						<td class="col-type">
<c:if test="${converterJob.status eq 'ready'}">준비</c:if>
<c:if test="${converterJob.status eq 'success'}">성공</c:if>
<c:if test="${converterJob.status eq 'waiting'}">승인대기</c:if>
<c:if test="${converterJob.status eq 'fail'}">실패</c:if>
						</td>
						<td class="col-count"><fmt:formatNumber value="${converterJob.fileCount}" type="number"/> 개</td>
						<td class="col-type">
<c:if test="${empty converterJob.errorCode }">
							없음
</c:if>
<c:if test="${!empty converterJob.errorCode }">
							<a href="#" onclick="detailErrorCode('${converterJob.errorCode}'); return false;">[보기]</a>
</c:if>
						</td>
						<td class="col-type">
							<fmt:parseDate value="${converterJob.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
							<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
					</tr>
</c:forEach>
</c:if>
				</tbody>
			</table>
			</form:form>

		</div>
		<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
	</div>

</div>
<%@ include file="/WEB-INF/views/converter/error-dialog.jsp" %>
<!-- E: WRAP -->

<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var searchWord = "${converterJob.searchWord}";
		var searchOption = "${converterJob.searchOption}";
		var orderWord = "${converterJob.orderWord}";
		var orderValue = "${converterJob.orderValue}";
		var listCounter = "${converterJob.listCounter}";

		if(searchWord != "") $("#searchWord").val("${converterJob.searchWord}");
		if(searchOption != "") $("#searchOption").val("${converterJob.searchOption}");
		if(orderWord != "") $("#orderWord").val("${converterJob.orderWord}");
		if(orderValue != "") $("#orderValue").val("${converterJob.orderValue}");
		if(listCounter != "") $("#listCounter").val("${converterJob.listCounter}");

		initDatePicker();
		initCalendar(new Array("startDate", "endDate"), new Array("${converterJob.startDate}", "${converterJob.endDate}"));
	});

	//전체 선택
	$("#chkAll").click(function() {
		$(":checkbox[name=uploadDataId]").prop("checked", this.checked);
	});

	// 프로젝트 다이얼 로그
	var errorDialog = $( ".errorDialog" ).dialog({
		autoOpen: false,
		width: 400,
		height: 500,
		modal: true,
		resizable: false
	});

	function detailErrorCode(errorCode) {
		errorDialog.dialog( "open" );
		$("#dialog_error_code").html(errorCode);
	}
</script>
</body>
</html>
