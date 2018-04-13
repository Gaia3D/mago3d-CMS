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
		    				<form:form id="reportMaintenance" modelAttribute="reportMaintenance" method="post" action="/report/list-report-maintenance.do">
							<div class="input-group row">
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
					                	<option value="user_id"> 아이디 </option>
										<option value="user_name"> 이름 </option>
										<option value="last_login_date"> 로그인날짜 </option>
										<option value="register_date"> 등록일 </option>
									</select>
									<select id="order_value" name="order_value" class="select">
				                		<option value=""> 기본 </option>
					                	<option value="ASC"> 오름차순 </option>
										<option value="DESC"> 내림차순 </option>
									</select>
								</div>
								<div class="input-set">
									<input type="submit" value="검색" />
								</div>
							</div>
							</form:form>
						</div>
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									전체: <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em>건, 
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
								</div>
								<div class="list-functions u-pull-right">
									<div class="button-group">
										<a href="#" id="reportSpinner" class="button" title="레포트 생성" onclick="createReport();">레포트 생성</a>
									</div>
								</div>
							</div>
							<table class="list-table scope-col">
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-ip" />
								<col class="col-number" />
								<col class="col-number" />
								<col class="col-desc" />
								<col class="col-date-time" />
								<thead>
									<tr>
										<th scope="col" class="col-number">번호</th>
										<th scope="col" class="col-name">서비스명</th>
										<th scope="col" class="col-ip">IP</th>
										<th scope="col" class="col-number">서버 수</th>
										<th scope="col" class="col-number">사용자 수</th>
										<th scope="col" class="col-functions">상세보기</th>
										<th scope="col" class="col-date-time">등록일</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty reportMaintenanceList }">
									<tr>
										<td colspan="7" class="col-none">정기 점검 레포트가 존재하지 않습니다. </td>
									</tr>
</c:if>
<c:if test="${!empty reportMaintenanceList }">
	<c:forEach var="reportMaintenance" items="${reportMaintenanceList}" varStatus="status">
									<tr>
										<td class="col-number">${pagination.rowNumber - status.index}</td>
										<td class="col-name">${reportMaintenance.service_name}</td>
										<td class="col-ip">${reportMaintenance.ip}</td>
										<td class="col-number">${reportMaintenance.server_total_count}</td>
										<td class="col-number">${reportMaintenance.user_total_count}</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="#" onclick="viewReportMaintenance('${reportMaintenance.report_maintenance_id}'); return false;" class="image-button">인쇄</a>
											</span>
										</td>
										<td class="col-date-time">${reportMaintenance.viewRegisterDate}</td>
									</tr>
	</c:forEach>
</c:if>
								</tbody>
							</table>
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
		alert("개발중 입니다.");
		initJqueryCalendar();
		
		initSelect(	new Array("order_word", "order_value"), 
				new Array("${reportMaintenance.order_word}", "${reportMaintenance.order_value}"));
		initCalendar(new Array("start_date", "end_date"), new Array("${reportMaintenance.start_date}", "${reportMaintenance.end_date}"));
		$( ".select" ).selectmenu();
	});
	
	var createReportFlag = true;
	function createReport() {
		if(createReportFlag) {
			createReportFlag = false;		
			$("#reportSpinner").html("레포트 생성중...");
			$.ajax({
				url: "/report/ajax-insert-report-maintenance.do",
				type: "POST",
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
						location.reload();
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					createReportFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        createReportFlag = true;
			        $("#reportSpinner").html("레포트 생성");
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 레포트 팝업 보기
	function viewReportMaintenance(report_maintenance_id) {
		var url = "/report/detail-report-maintenance.do?report_maintenance_id=" + report_maintenance_id;
		popupOpen(url, "정기점검 레포트", 1000, 700);
	}
</script>
</body>
</html>