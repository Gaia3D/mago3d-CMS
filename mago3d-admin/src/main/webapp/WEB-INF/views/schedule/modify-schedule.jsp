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
		    			<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='user.input.check.box'/></div>
			    
						<form:form id="schedule" modelAttribute="schedule" method="post" action="/schedule/update-schedule.do" onsubmit="return check();">
							<form:hidden path="schedule_id" />
						<legend>schedule</legend>
						<fieldset>
					  		<ul>
						  		<li style="line-height: 30px;">
						  			<span style="display:inline-block; width: 200px;">
								  		<form:label path="name">스케줄명</form:label>
						 			</span>
						 			<span>
							  			<form:input path="name" />
							  			<form:errors path="name" cssClass="error" />
							  		</span>
						  		</li>
						  		<li style="line-height: 30px;">
						  			<span style="display:inline-block; width: 200px;">
								  		<form:label path="system_group_id">대상</form:label>
						 			</span>
						 			<span>
										<form:input path="system_group_id" />
										<form:hidden path="account_group_id" />&nbsp;&nbsp;
										<a href="#" onclick="findGroup()">찾기</a>	
										<form:errors path="system_group_id" cssClass="error" />
							  		</span>
						  		</li>
						  		<li style="line-height: 30px;">
						  			<span style="display:inline-block; width: 200px;">
								  		<form:label path="expression">실행 표현식</form:label>
						 			</span>
						 			<span>
							  			<form:input path="expression" />
							  			<form:errors path="expression" cssClass="error" />
							  		</span>
						  		</li>
						  		<li style="line-height: 30px;">
						  			<span style="display:inline-block; width: 200px;">
								  		<form:label path="start_date">시작시간</form:label>
						 			</span>
						 			<span>
										<form:input path="start_date" />
							  			<form:errors path="start_date" cssClass="error" />
							  		</span>
						  		</li>
						  		<li style="line-height: 30px;">
						  			<span style="display:inline-block; width: 200px;">
								  		<form:label path="end_time">종료시간</form:label>
						 			</span>
						 			<span>
										<form:input path="end_time" />
							  			<form:errors path="end_time" cssClass="error" />
							  		</span>
						  		</li>
						  		<li style="line-height: 30px;">
						  			<span style="display:inline-block; width: 200px;">
								  		<form:label path="description">설명</form:label>
						 			</span>
						 			<span>
										<form:input path="description" />
							  			<form:errors path="description" cssClass="error" />
							  		</span>
						  		</li>
						  		<li style="line-height: 30px;">
						  			<span style="display:inline-block; width: 200px;">
								  		<form:label path="execute_server">실행 주체</form:label>
						 			</span>
						 			<span>
										<form:select path="execute_server">
											<option value="0">WEB</option>
											<option value="1">엔진</option>
										</form:select>
							  			<form:errors path="execute_server" cssClass="error" />
							  		</span>
						  		</li>
						  		<li style="line-height: 30px;">
						  			<span style="display:inline-block; width: 200px;">
								  		<form:label path="use_yn">사용유무</form:label>
						 			</span>
						 			<span>
										<form:select path="use_yn">
											<option value="Y">사용</option>
											<option value="N">미사용</option>
										</form:select>
							  			<form:errors path="use_yn" cssClass="error" />
							  		</span>
						  		</li>
						  		<li style="text-align: center;">
						  			<input type="submit" value="저장" />&nbsp;&nbsp;
						  			<a href="/schedule/list-schedule.do">목록</a>
						  		</li>
						 	</ul>
						</fieldset>
						</form:form>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
			
<script src="/externlib/${lang}/jquery/jquery.js"></script>
<script src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>		
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
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