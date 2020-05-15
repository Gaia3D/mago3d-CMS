<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 변경 요청 이력 | mago3D</title>
	<link rel="shortcut icon" href="/images/favicon.ico?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/json-viewer/json-viewer.css?cacheVersion=${contentCacheVersion}" />
	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/json-viewer/json-viewer.js?cacheVersion=${contentCacheVersion}"></script>
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
			<form:form id="searchForm" modelAttribute="dataInfoLog" method="get" action="/data-log/list" onsubmit="return searchCheck();">
			<div class="input-group row">
				<div class="input-set">
					<label for="searchWord"><spring:message code='search.word'/></label>
					<select id="searchWord" name="searchWord" class="selectBoxClass">
						<option value=""><spring:message code='select'/></option>
	          			<option value="data_name">데이터명</option>
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
						<option value="data_name">데이터명</option>
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
			<form:form id="listForm" modelAttribute="dataInfo" method="post">
			<input type="hidden" id="checkIds" name="checkIds" value="" />
			<div class="list-header row">
				<div class="list-desc u-pull-left">
					<spring:message code='all.d'/> <span class="totalCount"><fmt:formatNumber value="${pagination.totalCount}" type="number"/></span> <spring:message code='search.what.count'/>,
					<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
				</div>
			</div>
			<table class="list-table scope-col">
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
						<th scope="col" class="col-checkbox"><input type="checkbox" id="chkAll" name="chkAll" /></th>
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
							<input type="checkbox" id="dataInfoLogId_${dataInfoLog.dataLogId}" name="dataLogId" value="${dataInfoLog.dataLogId}" />
						</td>
						<td class="col-number">${pagination.rowNumber - status.index }</td>
						<td class="col-name ellipsis" style="min-width:100px;max-width:100px;">${dataInfoLog.dataGroupName}</td>
						<td class="col-name ellipsis" style="min-width:160px;max-width:160px;">${dataInfoLog.dataName}</td>
						<td class="col-type">${dataInfoLog.userId}</td>
						<td class="col-type">${dataInfoLog.dataType}</td>
						<td class="col-type">${dataInfoLog.sharing}</td>
						<td class="col-type ellipsis" style="min-width:80px;max-width:80px;">${dataInfoLog.mappingType}</td>
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
<!-- E: WRAP -->

<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js?cacheVersion=${contentCacheVersion}"></script>
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
