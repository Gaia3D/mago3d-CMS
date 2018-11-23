<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Converter 파일 목록 | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css?cache_version=${cache_version}">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/cloud.js?cache_version=${cache_version}"></script>
</head>
<body>

<div class="site-body">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<div id="site-content" class="on">
		<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
		<div id="content-wrap">
			<div id="gnb-content" class="clfix">
				<h1 style="padding-left: 20px;">
					<span style="font-size:26px;">Converter 파일 목록</span>
				</h1>
				<div class="location">
					<span style="padding-top:10px; font-size:12px; color: Mediumslateblue;">
						<i class="fas fa-cubes" title="Converter"></i>
					</span>
					<span style="font-size:12px;">Converter > Converter 파일 목록</span>
				</div>
			</div>
			
			<div class="page-content">
				<div class="filters">
	   				<form:form id="searchForm" modelAttribute="converterJobFile" method="post" action="/converter/list-converter-job-file.do" onsubmit="return searchCheck();">
					<div class="input-group row">
						<div class="input-set">
							<label for="search_word"><spring:message code='search.word'/></label>
							<select id="search_word" name="search_word" class="select" style="height: 30px;">
								<option value=""><spring:message code='select'/></option>
			          			<option value="file_name">파일명</option>
							</select>
							<select id="search_option" name="search_option" class="select" style="height: 30px;">
								<option value="0"><spring:message code='search.same'/></option>
								<option value="1"><spring:message code='search.include'/></option>
							</select>
							<form:input path="search_value" type="search" cssClass="m" cssStyle="float: right;" />
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
								<option value="title">제목</option>
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
					<form:form id="listForm" modelAttribute="converterJobFile" method="post">
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
						<thead>
							<tr>
								<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
								<th scope="col" class="col-number"><spring:message code='number'/></th>
								<th scope="col" class="col-functions">공유타입</th>
								<th scope="col" class="col-name">데이터 타입</th>
								<th scope="col" class="col-name">파일명</th>
								<th scope="col" class="col-functions">상태</th>
								<th scope="col" class="col-functions">에러코드</th>
								<th scope="col" class="col-date"><spring:message code='insert.date'/></th>
							</tr>
						</thead>
						<tbody>
<c:if test="${empty converterJobFileList }">
							<tr>
								<td colspan="8" class="col-none">Converter Job File 이 존재하지 않습니다.</td>
							</tr>
</c:if>
<c:if test="${!empty converterJobFileList }">
<c:forEach var="converterJobFile" items="${converterJobFileList}" varStatus="status">
							<tr>
								<td class="col-checkbox">
									<input type="checkbox" id="converter_job_file_id_${converterJobFile.converter_job_file_id}" name="converter_job_file_id" 
										value="${converterJobFile.converter_job_file_id}" />
								</td>
								<td class="col-number">${pagination.rowNumber - status.index }</td>
								<td class="col-functions">
	<c:if test="${converterJobFile.sharing_type eq '0' }">
									공통 프로젝트
	</c:if>
	<c:if test="${converterJobFile.sharing_type eq '1' }">
									공개 프로젝트
	</c:if>
	<c:if test="${converterJobFile.sharing_type eq '2' }">
									개인 프로젝트
	</c:if>
	<c:if test="${converterJobFile.sharing_type eq '3' }">
									공유 프로젝트
	</c:if>							
								</td>
								<td class="col-name">${converterJobFile.data_type }</td>
								<td class="col-functions">
									${converterJobFile.file_name }
								</td>
								<td class="col-name" style="text-align: right;">
	<c:if test="${converterJobFile.status eq '0'}">준비</c:if>
	<c:if test="${converterJobFile.status eq '1'}">성공</c:if>
	<c:if test="${converterJobFile.status eq '2'}">확인필요</c:if>
	<c:if test="${converterJobFile.status eq '3'}">실패</c:if>							
								</td>
								<td class="col-functions">
	<c:if test="${empty converterJobFile.error_code }">
									없음
	</c:if>
	<c:if test="${!empty converterJobFile.error_code }">
									<a href="#" onclick="detailErrorCode('${converterJobFile.error_code}'); return false;">[보기]</a>
	</c:if>
								</td>
								<td class="col-name">${converterJobFile.viewInsertDate }</td>
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
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<%@ include file="/WEB-INF/views/converter/error-dialog.jsp" %>

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	
	//전체 선택 
	$("#chk_all").click(function() {
		$(":checkbox[name=converter_job_file_id]").prop("checked", this.checked);
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
