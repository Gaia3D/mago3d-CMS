<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
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
		    				<form:form id="searchForm" modelAttribute="scheduleLog" method="post" action="/schedule/list-schedule-log.do" onsubmit="return searchCheck();">
							<div class="input-group row">
								<div class="input-set">
									<label for="search_word">검색어</label>
									<select id="search_word" name="search_word" class="select">
										<option value="">선택</option>
					                	<option value="schedule_name">스케줄명</option>
									</select>
									<select id="search_option" name="search_option" class="select">
										<option value="0">일치</option>
										<option value="1">포함</option>
									</select>
									<form:input path="search_value" type="search" cssClass="m" />
								</div>
								<div class="input-set">
									<label for="execute_result">결과</label>
									<select id="execute_result" name="execute_result" class="select">
										<option value="">전체</option>
										<option value="0"> 성공 </option>
										<option value="1"> 실패 </option>
										<option value="2"> 부분성공 </option>
									</select>
								</div>
								<div class="input-set">
									<label for="start_date">날짜</label>
									<input type="text" class="s date" id="start_date" name="start_date" />
									<span class="delimeter tilde">~</span>
									<input type="text" class="s date" id="end_date" name="end_date" />
								</div>
								<div class="input-set">
									<label for="order_word">표시순서</label>
									<select id="order_word" name="order_word" class="select">
										<option value=""> 기본 </option>
					                	<option value="register_date"> 등록일 </option>
									</select>
									<select id="order_value" name="order_value" class="select">
				                		<option value=""> 기본 </option>
					                	<option value="ASC"> 오름차순 </option>
										<option value="DESC"> 내림차순 </option>
									</select>
									<!-- <select id="list_counter" name="list_counter" class="select">
				                		<option value="10"> 10 개씩 </option>
					                	<option value="50"> 50 개씩 </option>
										<option value="100"> 100 개씩 </option>
									</select> -->
								</div>
								<div class="input-set">
									<input type="submit" value="검색" />
								</div>
							</div>
							</form:form>
						</div>
						<div class="list">
							<form:form id="scheduleLog" modelAttribute="scheduleLog" method="post">
								<input type="hidden" id="check_ids" name="check_ids" value="" />
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									전체: <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em>건, 
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
								</div>
							</div>
							<table class="list-table scope-col">
									<col class="col-checkbox" />
									<col class="col-number" />
									<col class="col-name" />
									<col class="col-toggle" />
									<col class="col-desc" />
									<col class="col-date" />
									<thead>
										<tr>
											<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
											<th scope="col" class="col-number">번호</th>
											<th scope="col" class="col-name">스케줄명</th>
											<th scope="col" class="col-toggle">결과</th>
											<th scope="col" class="col-desc">상세내용</th>
											<th scope="col" class="col-date">등록일</th>
										</tr>
									</thead>
									<tbody>
<c:if test="${empty scheduleLogList }">
										<tr>
											<td colspan="6" class="col-none">스케줄 이력이 존재하지 않습니다.</td>
										</tr>
</c:if>
<c:if test="${!empty scheduleLogList }">
	<c:forEach var="scheduleLog" items="${scheduleLogList}" varStatus="status">
										<tr>
											<td class="col-checkbox">
												<input type="checkbox" id="schedule_log_id_${scheduleLog.schedule_log_id}" name="schedule_log_id" value="${scheduleLog.schedule_log_id}" />
											</td>
											<td class="col-number">${pagination.rowNumber - status.index }</td>
											<td class="col-name">${scheduleLog.schedule_name }</td>
											<td class="col-toggle"><a href="#" onclick="alert('상세 이력 서비스 준비중입니다.'); return false;">${scheduleLog.viewExecuteResult }</a></td>
											<td class="col-desc">${scheduleLog.execute_message }</td>
											<td class="col-date">${scheduleLog.viewRegisterDate }</td>
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
	
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.form.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initJqueryCalendar();
		
		initSelect(	new Array("execute_result", "search_word", "search_option", "search_value", "order_word", "order_value"), 
					new Array("${scheduleLog.execute_result}", "${scheduleLog.search_word}", "${scheduleLog.search_option}", "${scheduleLog.search_value}", "${scheduleLog.order_word}", "${scheduleLog.order_value}"));
		initCalendar(new Array("start_date", "end_date"), new Array("${scheduleLog.start_date}", "${scheduleLog.end_date}"));
		$( ".select" ).selectmenu();
	});
	
	// 전체 선택 
	$("#chk_all").click(function() {
		$(":checkbox[name=schedule_log_id]").prop("checked", this.checked);
	});
	
	function searchCheck() {
		if($("#search_option").val() == "1") {
			if(confirm(JS_MESSAGE["search.option.warning"])) {
				// go
			} else {
				return false;
			}
		} 
		
		var start_date = $("#start_date").val();
		var end_date = $("#end_date").val();
		if(start_date != null && start_date != "" && end_date != null && end_date != "") {
			if(parseInt(start_date) > parseInt(end_date)) {
				alert(JS_MESSAGE["search.date.warning"]);
				$("#start_date").focus();
				return false;
			}
		}
		return true;
	}
</script>
</body>
</html>