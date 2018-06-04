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
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
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
							<form:form id="aPILog" modelAttribute="aPILog" method="post" action="/api/list-api-log.do" onsubmit="return searchCheck();">
								<div class="input-group row">
									<div class="input-set">
										<label for="search_word">검색어</label>
										<select id="search_word" name="search_word" class="select">
											<option value=""> 선택 </option>
						                	<option value="service_code"> API 코드 </option>
											<option value="service_name"> API 이름 </option>
											<option value="user_id"> 아이디 </option>
										</select>
										<select id="search_option" name="search_option" class="select">
											<option value="0">일치</option>
											<option value="1">포함</option>
										</select>
										<form:input path="search_value" cssClass="m" />
									</div>
									<div class="input-set">
										<label for="success_yn">성공여부</label>
											<select id="success_yn" name="success_yn" class="select">
												<option value=""> 전체 </option>
												<option value="Y"> 성공 </option>
												<option value="N"> 실패 </option>
											</select>
									</div>
									<div class="input-set">
										<label for="start_date">기간</label>
										<input type="text" id="start_date" name="start_date" class="s date" />
										<span class="delimeter tilde">~</span>
										<input type="text" id="end_date" name="end_date" class="s date" />
									</div>
									<div class="input-set">
										<label for="order_word">표시순서</label>
										<select id="order_word" name="order_word" class="select">
											<option value=""> 기본 </option>
						                	<option value="service_code"> API 코드 </option>
											<option value="service_name"> API 이름 </option>
											<option value="user_id"> 아이디 </option>
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
							</div>
							<table class="list-table scope-col">
								<col class="col-number" />
								<col class="col-key" />
								<col class="col-name" />
								<col class="col-ip" />
								<col class="col-type" />
								<col class="col-id" />
								<col class="col-toggle" />
								<col class="col-type" />
								<col class="col-date-time" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-number">번호</th>
										<th scope="col" class="col-key">API 코드</th>
										<th scope="col" class="col-name">API 이름</th>
										<th scope="col" class="col-ip">Client IP</th>
										<th scope="col" class="col-type" style="min-width: 50px;">사용매체</th>
										<th scope="col" class="col-id">아이디</th>
										<th scope="col" class="col-toggle">성공여부</th>
										<th scope="col" class="col-type">요청타입</th>
										<th scope="col" class="col-date-time">등록일</th>
										<th scope="col" class="col-functions">상세</th>
									</tr>
								</thead>
								<tbody id="ajaxAPILogList">
									<tr>
										<td colspan="10" class="col-none">
											<div id="ajaxAPILogListSpinner" style="width: 100%; height: 50px; margin-top: 10px;"></div>
										</td>
									</tr>
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
	
	<div class="dialog" title="API 이력 상세 정보">
		<table class="inner-table scope-row">
			<col class="col-label" />
			<col class="col-data" />
			<tr>
				<th class="col-label" scope="row">API 코드</th>
				<td id="detail_service_code" class="col-key"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">API 이름</th>
				<td id="detail_service_name" class="col-name"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">Client IP</th>
				<td id="detail_client_ip" class="col-ip"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">사용매체</th>
				<td id="detail_device_kind" class="col-type"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">아이디</th>
				<td id="detail_user_id" class="col-id"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">요청타입</th>
				<td id="detail_request_type" class="col-type"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">성공여부</th>
				<td id="detail_success_yn" class="col-toggle"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">서비스 호출 메시지</th>
				<td id="detail_result_message" class="col-data"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">등록일</th>
				<td id="detail_register_date" class="col-data"></td>
			</tr>
		</table>
	</div>

<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript" src="/externlib/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/spinner/raphael.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initJqueryCalendar();
		
		initSelect(	new Array("search_word", "search_option", "search_value", "success_yn", "order_word", "order_value"), 
				new Array("${aPILog.search_word}", "${aPILog.search_option}", "${aPILog.search_value}", "${aPILog.success_yn}", "${aPILog.order_word}", "${aPILog.order_value}"));
			initCalendar(new Array("start_date", "end_date"), new Array("${aPILog.start_date}", "${aPILog.end_date}"));
		
		startSpinner("ajaxAPILogListSpinner");
		viewAPILogList();
		
		$( ".select" ).selectmenu();
	});
	
	function viewAPILogList() {
		var info = "totalCount=${totalCount}&pageNo=${pagination.pageNo }${pagination.searchParameters}";
		$.ajax({
			url: "/api/ajax-list-api-log.do",
			type: "POST",
			data: info,
			cache: false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var aPILogList = msg.aPILogList;
					var content = "";
					if(aPILogList == null || aPILogList.length == 0) {
						content = "<tr>"
								+	"<td colspan=\"10\" class=\"col-none\">서비스 요청 이력이 존재하지 않습니다.</td>"
								+ "</tr>";
					} else {
						var pageNumber = "${pagination.rowNumber}";
						for(var i=0; i<aPILogList.length; i++ ) {
							var aPILog = null;
							aPILog = aPILogList[i];
							
							content = content 
								+ "<tr>"
								+ 	"<td class=\"col-number\">" + (pageNumber - i) + "</td>"
								+ 	"<td class=\"col-key\">" + aPILog.service_code + "</td>"
								+ 	"<td class=\"col-name\">" + aPILog.service_name + "</td>"
								+ 	"<td class=\"col-ip\">" + aPILog.client_ip + "</td>"
								+ 	"<td class=\"col-type\">" + aPILog.viewDeviceKind + "</td>"
								+ 	"<td class=\"col-id\"><span class=\"long-desc\">" + aPILog.user_id + "</span></td>"
								+ 	"<td class=\"col-toggle\"><span class=\"long-desc\">" + aPILog.viewSuccessYn + "</span></td>"
								+ 	"<td class=\"col-type\"><span class=\"long-desc\">" + aPILog.request_type + "</span></td>"
								+ 	"<td class=\"col-date-time\">" + aPILog.viewRegisterDate + "</td>"
								+ 	"<td class=\"col-functions\"><a href=\"#\" onclick=\"detailApiLog('" + aPILog.api_log_id + "');\">보기</a></td>"
								+ "</tr>";		
						}
					}
					$("#ajaxAPILogList").empty();
					$("#ajaxAPILogList").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
	
	var dialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 470,
		width: 700,
		modal: true,
		resizable: false
	});
	
	// Api Log 상세 정보
    function detailApiLog(apiLogId) {
    	dialog.dialog( "open" );
    	ajaxApiLog(apiLogId);
	}
	// 상세 정보 조회
    function ajaxApiLog(apiLogId) {
    	$.ajax({
    		url: "/api/ajax-api-log.do",
    		data: { api_log_id : apiLogId },
    		type: "POST",
    		cache: false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				$("#detail_service_code").html(msg.aPILog.service_code);
    				$("#detail_service_name").html(msg.aPILog.service_name);
    				$("#detail_client_ip").html(msg.aPILog.client_ip);
    				$("#detail_device_kind").html(msg.aPILog.device_kind);
    				$("#detail_user_id").html(msg.aPILog.user_id);
    				$("#detail_request_type").html(msg.aPILog.request_type);
    				$("#detail_success_yn").html(msg.aPILog.success_yn);
    				$("#detail_result_message").html(msg.aPILog.result_message);
    				$("#detail_register_date").html(msg.aPILog.viewRegisterDate);
				} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
	
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