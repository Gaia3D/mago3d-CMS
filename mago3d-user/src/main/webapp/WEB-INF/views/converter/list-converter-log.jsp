<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>main | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<script type="text/javascript" src="/js/cloud.js"></script>
</head>
<body>

<div class="default-layout">
	<!-- 왼쪽 메뉴 -->
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<!-- 왼쪽 메뉴 -->
	
	<!--  컨텐츠 -->
	<div class="content-layout">
		<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
		<div>
			<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
			<div class="content-detail">
				
				<!-- Start content by page -->
				<div class="page-content">
					<div class="filters">
		   				<form:form id="searchForm" modelAttribute="converterLog" method="post" action="/converter/list-converter-log.do" onsubmit="return searchCheck();">
						<div class="input-group row">
							<div class="input-set">
								<label for="search_word"><spring:message code='search.word'/></label>
								<select id="search_word" name="search_word" class="select" style="height: 30px;">
									<option value=""><spring:message code='select'/></option>
				          			<option value="data_name">데이터명</option>
								</select>
								<select id="search_option" name="search_option" class="select" style="height: 30px;">
									<option value="0"><spring:message code='search.same'/></option>
									<option value="1"><spring:message code='search.include'/></option>
								</select>
								<form:input path="search_value" type="search" cssClass="m" />
							</div>
							<div class="input-set">
								<label for="start_date"><spring:message code='search.date'/></label>
								<input type="text" class="s date" id="start_date" name="start_date" />
								<span class="delimeter tilde">~</span>
								<input type="text" class="s date" id="end_date" name="end_date" />
							</div>
							<div class="input-set">
								<label for="order_word"><spring:message code='search.order'/></label>
								<select id="order_word" name="order_word" class="select" style="height: 30px;">
									<option value=""> <spring:message code='search.basic'/> </option>
									<option value="data_name">데이터명</option>
									<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
								</select>
								<select id="order_value" name="order_value" class="select" style="height: 30px;">
			                		<option value=""> <spring:message code='search.basic'/> </option>
				                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
									<option value="DESC"> <spring:message code='search.descending.order'/> </option>
								</select>
								<select id="list_counter" name="list_counter" class="select" style="height: 30px;">
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
						<form:form id="listForm" modelAttribute="converterLog" method="post">
						<div class="list-header">
							<div class="list-desc u-pull-left">
								<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
								<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
							</div>
						</div>
						
						<table class="list-table scope-col">
							<col class="col-checkbox" />
							<col class="col-number" />
							<col class="col-name" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<col class="col-functions" />
							<thead>
								<tr>
									<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
									<th scope="col" class="col-number"><spring:message code='number'/></th>
									<th scope="col" class="col-name">프로젝트</th>
									<th scope="col" class="col-name">데이터명</th>
									<th scope="col" class="col-functions">위도</th>
									<th scope="col" class="col-functions">경도</th>
									<th scope="col" class="col-functions">높이</th>
									<th scope="col" class="col-functions">Heading</th>
									<th scope="col" class="col-functions">Pitch</th>
									<th scope="col" class="col-functions">Roll</th>
									<th scope="col" class="col-functions">상태</th>
									<th scope="col" class="col-functions">변환 결과</th>
									<th scope="col" class="col-functions">정보</th>
									<th scope="col" class="col-date"><spring:message code='insert.date'/></th>
								</tr>
							</thead>
							<tbody>
<c:if test="${empty converterLogList }">
								<tr>
									<td colspan="14" class="col-none">Converter Log가 존재하지 않습니다.</td>
								</tr>
</c:if>
<c:if test="${!empty converterLogList }">
	<c:forEach var="converterLog" items="${converterLogList}" varStatus="status">
									<tr>
										<td class="col-checkbox">
											<input type="checkbox" id="converter_job_id_${converterLog.converter_log_id}" name="converter_log_id" value="${converterLog.converter_log_id}" />
										</td>
										<td class="col-number">${pagination.rowNumber - status.index }</td>
										<td class="col-name">${converterLog.project_name }</td>
										<td class="col-functions">IFC_JAPAN_${status.index }</td>
										<td class="col-functions">${converterLog.latitude}</td>
										<td class="col-functions">${converterLog.longitude}</td>
										<td class="col-functions">${converterLog.height}</td>
										<td class="col-functions">${converterLog.heading}</td>
										<td class="col-functions">${converterLog.pitch}</td>
										<td class="col-functions">${converterLog.roll}</td>
										<td class="col-functions">공간 정보 미입력</td>
										<td class="col-functions">성공</td>
										<td class="col-functions"><a href="/converter/modify-converter-log.do?converter_log_id=${converterLog.converter_log_id}" >수정</a></td>
										<td class="col-name">2018-08-16 12:52</td>
									</tr>
	</c:forEach>
</c:if>
							</tbody>
						</table>
						</form:form>
						
					</div>
					<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
				</div>
				<!-- End content by page -->
				
			</div>
			<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
		</div>
	</div>
	<!--  컨텐츠 -->
</div>

<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	
	//전체 선택 
	$("#chk_all").click(function() {
		$(":checkbox[name=converter_job_id]").prop("checked", this.checked);
	});
</script>
</body>
</html>
