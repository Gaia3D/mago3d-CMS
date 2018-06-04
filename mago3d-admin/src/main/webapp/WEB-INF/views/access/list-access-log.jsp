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
							<form:form id="accessLog" modelAttribute="accessLog" method="post" action="/access/list-access-log.do" onsubmit="return searchCheck();">
							<div class="input-group row">
								<div class="input-set">
									<label for="search_word">검색어</label>
									<select id="search_word" name="search_word" class="select">
										<option value="">선택</option>
										<option value="user_id">아이디</option>
										<option value="user_name">이름</option>
									</select>
									<select id="search_option" name="search_option" class="select">
										<option value="0">일치</option>
										<option value="1">포함</option>
									</select>
									<form:input path="search_value" cssClass="m" />
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
										<option value="">기본</option>
										<option value="user_id">아이디</option>
										<option value="user_name">이름</option>
										<option value="register_date">등록일</option>
									</select>
									<select id="order_value" name="order_value" class="select">
										<option value="">기본</option>
										<option value="ASC">오름차순</option>
										<option value="DESC">내림차순</option>
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
								<col class="col-id" />
								<col class="col-name" />
								<col class="col-ip" />
								<col class="col-url" />
								<col class="col-desc" />
								<col class="col-desc" />
								<col class="col-desc" />
								<col class="col-date-time" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-number">번호</th>
										<th scope="col" class="col-id">아이디</th>
										<th scope="col" class="col-name">이름</th>
										<th scope="col" class="col-ip">요청 IP</th>
										<th scope="col" class="col-url">URI</th>
										<th scope="col" class="col-desc">요청 Parameter</th>
										<th scope="col" class="col-desc">User Agent</th>
										<th scope="col" class="col-desc">Referer</th>
										<th scope="col" class="col-date-time">등록일</th>
										<th scope="col" class="col-functions">상세</th>
									</tr>
								</thead>
								<tbody id="ajaxAccessLogList">
									<tr>
										<td colspan="10" class="col-none">
											<div id="ajaxAccessLogListSpinner" style="width: 100%; height: 50px; margin-top: 10px;"></div>
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
	
	<div class="dialog" title="접근 이력 상세 정보">
		<table class="inner-table scope-row">
			<col class="col-label" />
			<col class="col-data" />
			<tr>
				<th class="col-label" scope="row">아이디</th>
				<td id="detail_user_id" class="col-data"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">이름</th>
				<td id="detail_user_name" class="col-data"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">요청 IP</th>
				<td id="detail_client_ip" class="col-data"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">URI</th>
				<td id="detail_request_uri" class="col-data"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">요청 Parameter</th>
				<td id="detail_parameters" class="col-data"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">User Agent</th>
				<td id="detail_user_agent" class="col-data"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">Referer</th>
				<td id="detail_referer" class="col-data"></td>
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
		
		initSelect(	new Array("search_word", "search_option", "search_value", "order_word", "order_value"), 
				new Array("${accessLog.search_word}", "${accessLog.search_option}", "${accessLog.search_value}", "${accessLog.order_word}", "${accessLog.order_value}"));
		initCalendar(new Array("start_date", "end_date"), new Array("${accessLog.start_date}", "${accessLog.end_date}"));
		$( ".select" ).selectmenu();
		
		startSpinner("ajaxAccessLogListSpinner");
		viewAccessLogList();
	});
	
	function viewAccessLogList() {
		//var listTemplate = $.templates("#listTemplate");
		var info = "totalCount=${totalCount}&pageNo=${pagination.pageNo }${pagination.searchParameters}";
		$.ajax({
			url: "/access/ajax-list-access-log.do",
			type: "POST",
			data: info,
			cache: false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
	//var html = listTemplate.render(msg);
					
					var accessLogList = msg.accessLogList;
					var content = "";
					if(accessLogList == null || accessLogList.length == 0) {
						content = "<tr>"
								+	"<td colspan=\"10\" class=\"col-none\">접속 이력이 존재하지 않습니다.</td>"
								+ "</tr>";
					} else {
						var pageNumber = "${pagination.rowNumber}";
						for(var i=0; i<accessLogList.length; i++ ) {
							var accessLog = null;
							accessLog = accessLogList[i];
							
							content = content 
								+ "<tr>"
								+ 	"<td class=\"col-number\">" + (pageNumber - i) + "</td>"
								+ 	"<td class=\"col-id\">" + accessLog.user_id + "</td>"
								+ 	"<td class=\"col-name\">" + accessLog.user_name + "</td>"
								+ 	"<td class=\"col-ip\">" + accessLog.client_ip + "</td>"
								+ 	"<td class=\"col-url\">" + accessLog.request_uri + "</td>"
								+ 	"<td class=\"col-desc\"><span class=\"long-desc\">" + accessLog.viewParameters + "</span></td>"
								+ 	"<td class=\"col-desc\"><span class=\"long-desc\">" + accessLog.viewUserAgent + "</span></td>"
								+ 	"<td class=\"col-desc\"><span class=\"long-desc\">" + accessLog.viewReferer + "</span></td>"
								+ 	"<td class=\"col-date-time\">" + accessLog.viewRegisterDate + "</td>"
								+ 	"<td class=\"col-functions\"><a href=\"#\" onclick=\"detailAccessLog('" + accessLog.access_log_id + "');\">보기</a></td>"
								+ "</tr>";		
						}
					}
					$("#ajaxAccessLogList").empty();
					$("#ajaxAccessLogList").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request,status,error){
		        //console.log('code:' + request.status + '\n' + 'message:' + request.responseText + '\n' + 'error:' + error);
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
	
	var dialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 430,
		width: 700,
		modal: true,
		resizable: false
	});
	
	// Access Log 상세 정보
    function detailAccessLog(accessLogId) {
    	dialog.dialog( "open" );
    	ajaxAccessLog(accessLogId);
	}
	// 상세 정보 조회
    function ajaxAccessLog(accessLogId) {
    	$.ajax({
    		url: "/access/ajax-access-log.do",
    		data: { access_log_id : accessLogId },
    		type: "POST",
    		cache: false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				$("#detail_user_id").html(msg.accessLog.user_id);
    				$("#detail_user_name").html(msg.accessLog.user_name);
    				$("#detail_client_ip").html(msg.accessLog.client_ip);
    				$("#detail_request_uri").html(msg.accessLog.request_uri);
    				$("#detail_parameters").html(msg.accessLog.parameters);
    				$("#detail_user_agent").html(msg.accessLog.user_agent);
    				$("#detail_referer").html(msg.accessLog.referer);
    				$("#detail_register_date").html(msg.accessLog.viewRegisterDate);
				} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
	
	/* $( "#search_option" ).selectmenu({
		change: function( event, ui ) {
			if($("#search_option").val() == "1") {
				alert(JS_MESSAGE["search.option.warning"]);
			}
		}
	}); */
	
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