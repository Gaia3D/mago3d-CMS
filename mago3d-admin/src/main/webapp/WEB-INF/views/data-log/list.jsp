<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 변경 요청 이력 | NDTP</title>
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
							<form:form id="searchForm" modelAttribute="dataInfoLog" method="get" action="/data-log/list" onsubmit="return searchCheck();">
								<div class="input-group row">
									<div class="input-set">
										<label for="searchWord" class="hiddenTag">검색유형</label>
										<select id="searchWord" name="searchWord" class="select" title="검색유형" style="height: 30px;">
											<option value=""><spring:message code='select'/></option>
						          			<option value="data_name">데이터명</option>
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
										<input type="text" class="s date" id="startDate" name="startDate" autocomplete="off" />
										<span class="delimeter tilde">~</span>
										<label for="endDate" class="hiddenTag">종료일</label>
										<input type="text" class="s date" id="endDate" name="endDate" autocomplete="off" />
									</div>
									<div class="input-set">
										<label for="orderWord"><spring:message code='search.order'/></label>
										<select id="orderWord" name="orderWord" class="select" style="height: 30px;">
											<option value=""> <spring:message code='search.basic'/> </option>
											<option value="data_name">데이터명</option>
											<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
										</select>
										<label for="orderValue" class="hiddenTag">정렬기준</label>
										<select id="orderValue" name="orderValue" class="select" title="정렬기준" style="height: 30px;">
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
						<form:form id="listForm" modelAttribute="dataInfo" method="post">
						<input type="hidden" id="checkIds" name="checkIds" value="" />
						<div class="list-header row">
							<div class="list-desc u-pull-left">
								<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em>
								<spring:message code='search.what.count'/>
								<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/>
								<spring:message code='search.page'/>
							</div>
						</div>
						<table class="list-table scope-col" summary="데이터 변경 이력 리스트">
						<caption class="hiddenTag">데이터 변경 이력</caption>
							<col class="col-checkbox" />
							<col class="col-number" />
							<col class="col-name" />
							<col class="col-name" />
							<col class="col-type" />
							<col class="col-type" />
							<col class="col-type" />
							<col class="col-type" />
							<col class="col-type" />
							<col class="col-date" />
							<thead>
								<tr>
									<th scope="col" class="col-checkbox"><label for="chkAll" class="hiddenTag">전체선택 체크박스</label><input type="checkbox" id="chkAll" name="chkAll" /></th>
									<th scope="col" class="col-number"><spring:message code='number'/></th>
									<th scope="col" class="col-name">그룹명</th>
									<th scope="col" class="col-name">데이터명</th>
									<th scope="col" class="col-type">요청자</th>
									<th scope="col" class="col-type">데이터타입</th>
									<th scope="col" class="col-type">공개유형</th>
									<th scope="col" class="col-type">매핑타입</th>
									<th scope="col" class="col-type">변경유형</th>
									<th scope="col" class="col-date">변경일</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${empty dataInfoLogList}">
								<tr>
									<td colspan="10" class="col-none">데이터 변경 이력이 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${!empty dataInfoLogList}">
							<c:forEach var="dataInfoLog" items="${dataInfoLogList}" varStatus="status">
								<tr>
									<td class="col-checkbox">
										<label for="dataInfoLogId_${dataInfoLog.dataLogId}" class="hiddenTag">선택 체크박스</label>
										<input type="checkbox" id="dataInfoLogId_${dataInfoLog.dataLogId}" name="dataLogId" value="${dataInfoLog.dataLogId}" />
									</td>
									<td class="col-number">${pagination.rowNumber - status.index }</td>
									<td class="col-name ellipsis" style="max-width:120px;">${dataInfoLog.dataGroupName}</td>
									<td class="col-name ellipsis" style="max-width:140px;">${dataInfoLog.dataName}</td>
									<td class="col-type">${dataInfoLog.userId}</td>
									<td class="col-type">${dataInfoLog.dataType}</td>
									<td class="col-type">${dataInfoLog.sharing}</td>
									<td class="col-type">${dataInfoLog.mappingType}</td>
									<td class="col-type">${dataInfoLog.changeType}</td>
									<td class="col-date">
										<fmt:parseDate value="${dataInfoLog.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
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

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var searchWord = "${dataInfoLog.searchWord}";
		var searchOption = "${dataInfoLog.searchOption}";
		var orderWord = "${dataInfoLog.orderWord}";
		var orderValue = "${dataInfoLog.orderValue}";
		var listCounter = "${dataInfoLog.listCounter}";

		if(searchWord != "") $("#searchWord").val("${dataInfoLog.searchWord}");
		if(searchOption != "") $("#searchOption").val("${dataInfoLog.searchOption}");
		if(orderWord != "") $("#orderWord").val("${dataInfoLog.orderWord}");
		if(orderValue != "") $("#orderValue").val("${dataInfoLog.orderValue}");
		if(listCounter != "") $("#listCounter").val("${dataInfoLog.listCounter}");

		initDatePicker();
		initCalendar(new Array("startDate", "endDate"), new Array("${dataInfoLog.startDate}", "${dataInfoLog.endDate}"));
	});

	//전체 선택
	$("#chkAll").click(function() {
		$(":checkbox[name=dataLogId]").prop("checked", this.checked);
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

		var searchValue = $('#searchValue').val();
		if (searchValue) {
			$('#searchValue').val(searchValue.trim());
		}

		return true;
	}
</script>
</body>
</html>
