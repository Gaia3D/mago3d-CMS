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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						</div>
						<form:form id="board" modelAttribute="board" method="post" onsubmit="return false;">			
						<table class="input-table scope-row">
							<col class="col-label" />
							<col class="col-input" />
							<tr>
								<th class="col-label" scope="row">
									<form:label path="title">제목</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="title" cssClass="xl" />
									<form:errors path="title" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="contents">내용</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:textarea path="contents" />
									<form:errors path="contents" cssClass="error" />
								</td>
							</tr>
							
							<tr>
								<th class="col-label" scope="row">
									<span>사용유무</span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input radio-set">
									<input type="radio" id="use_y" name="use_yn" value="Y" />
									<label for="use_y">사용</label>
									<input type="radio" id="use_n" name="use_yn" value="N" />
									<label for="use_n">사용안함</label>
								</td>
							</tr>
							
							<tr>
								<th class="col-label" scope="row"><form:label path="start_date">게시기간</form:label></th>
								<td class="col-input radio-set">
								<form:hidden path="start_date" />
								<form:hidden path="end_date" />
									<input type="text" id="start_day" name="start_day" class="s date" placeholder="날짜" />
									<input type="text" id="start_hour" name="start_hour" class="s" placeholder="시간" maxlength="2" />
									<span class="delimeter">:</span>
									<input type="text" id="start_minute" name="start_minute" class="s" placeholder="분" maxlength="2" />
									<span class="delimeter tilde">~</span>
									<input type="text" id="end_day" name="end_day" class="s date" placeholder="날짜" />
									<input type="text" id="end_hour" name="end_hour" class="s" placeholder="시간" maxlength="2" />
									<span class="delimeter">:</span>
									<input type="text" id="end_minute" name="end_minute" class="s" placeholder="분" maxlength="2" />
								</td>
							</tr>
						</table>
						<div class="button-group">
							<div id="insertBoardLink" class="center-buttons">
								<input type="submit" value="저장" onclick="insertBoard();" />
								<a href="/board/list-board.do" class="button">목록</a>
							</div>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
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
		$( ".select" ).selectmenu();
		
		$("[name=use_yn]").filter("[value='Y']").prop("checked",true);
	});
	
	function check() {
		if ($("#title").val() == "") {
			alert("제목을 입력하여 주십시오.");
			$("#title").focus();
			return false;
		}
		if ($("#contents").val() == "") {
			alert("내용을 입력하여 주십시오.");
			$("#contents").focus();
			return false;
		}
		if ($("#start_hour").val() > 23) {
			alert("게시 시작시간을 올바르게 설정하여 주십시오.");
			$("#start_hour").focus();
			return false;
		}
		if ($("#start_minute").val() > 59) {
			alert("게시 시작시간을 올바르게 설정하여 주십시오.");
			$("#start_minute").focus();
			return false;
		}
		if ($("#end_hour").val() > 23) {
			alert("게시 종료시간을 올바르게 설정하여 주십시오.");
			$("#end_hour").focus();
			return false;
		}
		if ($("#end_minute").val() > 59) {
			alert("게시 종료시간을 올바르게 설정하여 주십시오.");
			$("#end_minute").focus();
			return false;
		}
		
		if($("#start_day").val() != null && $("#start_day").val() != "") {
			if($("#start_hour").val() == null || $("#start_hour").val() == "") {
				alert("게시 시작 시간을 올바르게 설정하여 주십시오.");
				$("#start_hour").focus();
				return false;
			}
			if($("#start_minute").val() == null || $("#start_minute").val() == "") {
				alert("게시 시작 시간 분을 올바르게 설정하여 주십시오.");
				$("#start_minute").focus();
				return false;
			}
			if($("#end_hour").val() == null || $("#end_hour").val() == "") {
				alert("게시 종료 시간을 올바르게 설정하여 주십시오.");
				$("#end_hour").focus();
				return false;
			}
			if($("#end_minute").val() == null || $("#end_minute").val() == "") {
				alert("게시 종료 시간 분을 올바르게 설정하여 주십시오.");
				$("#end_minute").focus();
				return false;
			}
			
			$("#start_date").val($("#start_day").val() + $("#start_hour").val() + $("#start_minute").val() + "00");
			$("#end_date").val($("#end_day").val() +  + $("#end_hour").val() + $("#end_minute").val() + "59");
		}
	}
	
	// 저장
	var insertBoardFlag = true;
	function insertBoard() {
		if (check() == false) {
			return false;
		}
		if(insertBoardFlag) {
			insertBoardFlag = false;
			var info = $("#board").serialize();
			$.ajax({
				url: "/board/ajax-insert-board.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
						$("#insertBoardLink").empty();
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					insertBoardFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertBoardFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}	
	}
</script>
</body>
</html>