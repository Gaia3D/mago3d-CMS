<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 변환 결과 | mago3D</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
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
						<div class="filters">
							<form:form id="searchForm" modelAttribute="converterJob" method="get" action="/converter/list" onsubmit="return searchCheck();">
								<div class="input-group row">
									<div class="input-set">
										<label for="searchWord" class="hiddenTag">검색조건</label>
										<select id="searchWord" name="searchWord" title="검색조건" class="selectBoxClass">
											<option value=""><spring:message code='select'/></option>
						          			<option value="title">제목</option>
										</select>
										<label for="searchOption" class="hiddenTag">검색옵션</label>
										<form:select path="searchOption" class="select" title="검색옵션" style="height: 30px;">
											<form:option value="0"><spring:message code='search.same'/></form:option>
											<form:option value="1"><spring:message code='search.include'/></form:option>
										</form:select>
										<label for="searchValue"><spring:message code='search.word'/></label>
										<form:input path="searchValue" type="search" cssClass="m" cssStyle="float: right;" />
									</div>
									<div class="input-set">
										<label for="startDate"><spring:message code='search.date'/></label>
										<input type="text" class="s date" id="startDate" name="startDate" title="시작일" autocomplete="off" />
										<span class="delimeter tilde">~</span>
										<label for="endDate" class="hiddenTag">종료일</label>
										<input type="text" class="s date" id="endDate" name="endDate" title="종료일" autocomplete="off" />
									</div>
									<div class="input-set">
										<label for="orderWord"><spring:message code='search.order'/></label>
										<select id="orderWord" name="orderWord" class="selectBoxClass">
											<option value=""> <spring:message code='search.basic'/> </option>
											<option value="title">제목</option>
											<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
										</select>
										<label for="orderValue" class="hiddenTag">정렬기준</label>
										<select id="orderValue" name="orderValue" title="정렬기준" class="selectBoxClass">
					                		<option value=""> <spring:message code='search.basic'/> </option>
						                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
											<option value="DESC"> <spring:message code='search.descending.order'/> </option>
										</select>
										<label for="listCounter" class="hiddenTag">리스트건수</label>
										<form:select path="listCounter" class="select" title="리스트건수" style="height: 30px;">
					                		<form:option value="10"><spring:message code='search.ten.count'/></form:option>
						                	<form:option value="50"><spring:message code='search.fifty.count'/></form:option>
											<form:option value="100"><spring:message code='search.hundred.count'/></form:option>
										</form:select>
									</div>
									<div class="input-set">
										<input type="submit" value="<spring:message code='search'/>" />
									</div>
								</div>
								</form:form>
							</div>
							<div class="list">
								<form:form id="listForm" modelAttribute="uploadData" method="post">
									<input type="hidden" id="checkIds" name="checkIds" value="" />
								<div class="list-header row">
									<div class="list-desc u-pull-left">
										<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/>
										<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
									</div>
								</div>
								<table class="list-table scope-col" summary="데이터 변환 결과 ">
								<caption class="hiddenTag">데이터 변환 결과</caption>
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
				<c:if test="${converterJob.converterTemplate eq 'point-cloud'}">Point Cloud</c:if>
											</td>
											<td class="col-name">${converterJob.title }</td>
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
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/converter/error-dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
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

	function searchCheck() {
		if($("#searchOption").val() == "1") {
			if(confirm(JS_MESSAGE["search.option.warning"])) {
				// go
			} else {
				return false;
			}
		}

		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		if(startDate != null && startDate != "" && endDate != null && endDate != "") {
			if(parseInt(startDate) > parseInt(endDate)) {
				alert(JS_MESSAGE["search.date.warning"]);
				$("#startDate").focus();
				return false;
			}
		}
		return true;
	}

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
