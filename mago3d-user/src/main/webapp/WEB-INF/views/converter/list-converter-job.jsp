<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>main | mago3D User</title>
	<link rel="stylesheet" href="/externlib/sufee-template/css/bootstrap.min.css">
	<link rel="stylesheet" href="/externlib/sufee-template/css/font-awesome.min.css">
	<link rel="stylesheet" href="/externlib/sufee-template/css/themify-icons.css">
	<link rel="stylesheet" href="/externlib/sufee-template/scss/style.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/ko/style.css">
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
</head>
<body>
	
<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>

<div id="right-panel" class="right-panel">

	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
			
	<div class="content mt-3" style="min-height: 750px; background-color: white;">
	
		<div class="page-content">
			<div class="filters">
   				<form:form id="searchForm" modelAttribute="converterJob" method="post" action="/converter/list-converter-job.do" onsubmit="return searchCheck();">
				<div class="input-group row">
					<div class="input-set">
						<label for="search_word"><spring:message code='search.word'/></label>
						<select id="search_word" name="search_word" class="select">
							<option value=""><spring:message code='select'/></option>
		          			<option value="title">제목</option>
						</select>
						<select id="search_option" name="search_option" class="select">
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
						<select id="order_word" name="order_word" class="select">
							<option value=""> <spring:message code='search.basic'/> </option>
							<option value="title"> 제목 </option>
							<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
						</select>
						<select id="order_value" name="order_value" class="select">
	                		<option value=""> <spring:message code='search.basic'/> </option>
		                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
							<option value="DESC"> <spring:message code='search.descending.order'/> </option>
						</select>
						<select id="list_counter" name="list_counter" class="select">
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
						<thead>
							<tr>
								<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
								<th scope="col" class="col-number"><spring:message code='number'/></th>
								<th scope="col" class="col-name">title</th>
								<th scope="col" class="col-name">상태</th>
								<th scope="col" class="col-name">파일개수</th>
								<th scope="col" class="col-date"><spring:message code='insert.date'/></th>
								<th scope="col" class="col-functions">삭제</th>
							</tr>
						</thead>
						<tbody>
<c:if test="${empty converterJobList }">
							<tr>
								<td colspan="7" class="col-none">Converter Job이 존재하지 않습니다.</td>
							</tr>
</c:if>
<c:if test="${!empty converterJobList }">
<c:forEach var="converterJob" items="${converterJobList}" varStatus="status">
							<tr>
								<td class="col-checkbox">
									<input type="checkbox" id="converter_job_id_${converterJob.converter_job_id}" name="converter_job_id" value="${converterJob.converter_job_id}" />
								</td>
								<td class="col-number">${pagination.rowNumber - status.index }</td>
								<td class="col-name">${converterJob.title }</td>
								<td class="col-name">${converterJob.status}</td>
								<td class="col-name">${converterJob.converter_file_count}</td>
								<td class="col-name">${converterJob.viewInsertDate }</td>
								<td class="col-functions">
									<span class="button-group">
										<a href="/data/delete-data.do?data_id=${converterJob.converter_job_id }" onclick="return deleteWarning();" 
											class="image-button button-delete"><spring:message code='delete'/></a>
									</span>
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
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<script src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script src="/externlib/sufee-template/js/plugins.js"></script>
<script src="/externlib/sufee-template/js/main.js"></script>
<script src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	jQuery.noConflict();

	//전체 선택 
	jQuery("#chk_all").click(function() {
		jQuery(":checkbox[name=converter_job_id]").prop("checked", this.checked);
	});
</script>
</body>
</html>
