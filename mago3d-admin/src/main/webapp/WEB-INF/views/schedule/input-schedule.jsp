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
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='user.input.check.box'/></div>
						<form:form id="schedule" modelAttribute="schedule" method="post" action="/schedule/insert-schedule.do" onsubmit="return check();">
						<table class="input_area">
						<legend>schedule</legend>
					  		<tr>
						  		<th width="15%">
						  			<form:label path="name" cssClass="nessItem">스케줄명</form:label>
						 		</th>
						 		<td colspan="2">
						 			<form:input path="name" class="input_default" />
							  		<form:errors path="name" cssClass="error" />
						  		</td>
						  	</tr>
						  	<tr>
						  		<th>
						  			<form:label path="system_group_id">대상</form:label>
						 		</th>
						 		<td colspan="2">
									<form:input path="system_group_id" class="input_default" />
									<form:hidden path="account_group_id" />&nbsp;&nbsp;
									<a href="#" onclick="findGroup()" class="buttonPro small">찾기</a>	
									<form:errors path="system_group_id" cssClass="error" />
						  		</td>
						  	</tr>
						  	<tr>
						  		<th>
						  			<form:label path="use_yn">사용유무</form:label>
						 		</th>
						 		<td colspan="2">
									<form:select path="use_yn" class="select_default">
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</form:select>
						  			<form:errors path="use_yn" cssClass="error" />
						  		</td>
						  	</tr>
						  	<tr>
						  		<th rowspan="4">
						  			<form:label path="schedule_type" cssClass="nessItem">스케줄</form:label>
						 		</th>
						 		<td width="100px">
						 			<form:radiobutton path="schedule_type" value="0" label="실행 표현식" cssClass="marR10" />
						  		</td>
						  		<td>
						 			<form:input path="expression" class="input_default" />
						  			<form:errors path="expression" cssClass="error" />
						  		</td>
						  	</tr>
						  	<tr>
						 		<td>
						 			<form:radiobutton path="schedule_type" value="1" label="월별" cssClass="marR10" />
						  		</td>
						  		<td rowspan="3">
							  		<ul>
							  			<li>
							  				<form:label path="start_date" cssClass="nessItem">시작 시간</form:label>
							  				<input type="text" id="start_date_day" name="start_date_day" class="txt_18" size="10"/>&nbsp;
							  				<select id="start_date_hour" name="start_date_hour" style="height: 20px;">
							  					<option value="">시간</option>
							  				</select>&nbsp;
							  				<select id="start_date_minute" name="start_date_minute" style="height: 20px;">
							  					<option value="">분</option>
							  				</select>
							  			</li>
							  			<li>
							  				<form:label path="end_date" cssClass="nessItem">종료 시간</form:label>
							  				<input type="text" id="end_date_day" name="end_date_day" class="txt_18" size="10"/>&nbsp;
							  				<select id="end_date_hour" name="end_date_hour" style="height: 20px;">
							  					<option value="">시간</option>
							  				</select>&nbsp;
							  				<select id="end_date_minute" name="end_date_minute" style="height: 20px;">
							  					<option value="">분</option>
							  				</select>
							  			</li>
							  			<li id="week" style="display: none; margin-top: 5px; !important">
								 			<input type="checkbox" id="sun" name="sun" value="6" class="marL5" />&nbsp;일
								 			<input type="checkbox" id="mon" name="mon" value="0" class="marL5" />&nbsp;월
								 			<input type="checkbox" id="tue" name="tue" value="1" class="marL5" />&nbsp;화
								 			<input type="checkbox" id="wed" name="wed" value="2" class="marL5" />&nbsp;수
								 			<input type="checkbox" id="thu" name="thu" value="3" class="marL5" />&nbsp;목
								 			<input type="checkbox" id="fri" name="fri" value="4" class="marL5" />&nbsp;금
								 			<input type="checkbox" id="sat" name="sat" value="5" class="marL5" />&nbsp;토
							  			</li>
							  		</ul>
						  		</td>
						  	</tr>
						  	<tr>
						 		<td>
						 			<form:radiobutton path="schedule_type" value="2" label="주별" cssClass="marR10" />
						  		</td>
						  	</tr>
						  	<tr>
						 		<td>
						 			<form:radiobutton path="schedule_type" value="3" label="일별" cssClass="marR10" />
						  		</td>
						  	</tr>
						  	<tr>
						  		<th>
						  			<form:label path="execute_server">실행 주체</form:label>
						 		</th>
						 		<td colspan="2">
									<form:select path="execute_server" class="select_default">
										<option value="0">WEB</option>
										<option value="1">엔진</option>
									</form:select>
						  			<form:errors path="execute_server" cssClass="error" />
						  		</td>
						  	</tr>
						  	<tr>
						  		<th>
						  			<form:label path="description">설명</form:label>
						 		</th>
						 		<td colspan="2">
									<form:input path="description" class="input_default"  style="width: 700px;"/>
						  			<form:errors path="description" cssClass="error" />
						  		</td>
						  	</tr>
						  	<tr style="line-height: 40px;">
						  		<td colspan="3" style="text-align: center;">
						  			<input type="submit" value="저장" class="buttonPro purple" />
						  			<a href="/schedule/list-schedule.do" class="buttonPro purple">목록</a>
						  		</td>
						 	</tr>
						</table>
						</form:form>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script src="/externlib/jquery/jquery.js"></script>
<script src="/externlib/jquery-ui/jquery-ui.js"></script>		
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("[name=schedule_type]").filter("[value='0']").prop("checked", true);
		
		// 시작/종료 날짜 설정
		$("#start_date_day").datepicker({dateFormat: 'yy-mm-dd'}).datepicker('setDate', new Date());
		$("#end_date_day").datepicker({dateFormat: 'yy-mm-dd'}).datepicker('setDate', new Date());
		
		// 시작/종료 날짜의 시간/분 값 설정
		setTimeValue();
	});
	
	// 시작/종료 날짜의 시간/분 값 설정
	function setTimeValue() {
		for(var i=0; i<24; i++) {
			$("#start_date_hour").append("<option value='"+ i +"'>" + i + "</option>");
			$("#end_date_hour").append("<option value='"+ i +"'>" + i + "</option>");
		}
		
		for(var i=0; i<60; i++) {
			$("#start_date_minute").append("<option value='"+ i +"'>" + i + "</option>");
			$("#end_date_minute").append("<option value='"+ i +"'>" + i + "</option>");
		}
	}
	
	$("[name=schedule_type]").click(function() {
		if($("[name=schedule_type]")[1].checked == true || $("[name=schedule_type]")[2].checked == true) {
			$("#week").css("display", "");
		} else {
			$("#week").css("display", "none");
		}
	});
	
	function check() {
		if ($("#name").val() == "") {
			alert("스케줄명을 입력하여 주십시오.");
			$("#name").focus();
			return false;
		}
		if ($("#start_date").val() == "") {
			alert("시작시간을 해 주십시오.");
			$("#start_date").focus();
			return false;
		}
		if ($("#end_date").val() == "") {
			alert("종료시간을 해 주십시오.");
			$("#end_date").focus();
			return false;
		}
	}
	
	function findGroup() {
		
	}
</script>
</body>
</html>