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
						<div class="inner-header row">
							<div class="content-title u-pull-left">Schedule 상세 내용</div>
						</div>
		    			<table class="inner-table scope-row">
							<tr>
				  				<th width="25%">스케줄명</th>
					 			<td>${schedule.name}</td>
					  		</tr>
					  		<tr>
					  			<th>시스템 그룹 고유키</th>
					 			<td>${schedule.system_group_id}</td>
					  		</tr>
					  		<tr>
					  			<th>계정 그룹 고유키</th>
					 			<td>${schedule.account_group_id}</td>
					  		</tr>
					  		<tr>
					  			<th>스케줄 실행 Quartz 표현식</th>
					 			<td>${schedule.expression}</td>
					  		</tr>
					  		<tr>
					  			<th>시작 시간 yyyymmddhh24miss</th>
					 			<td>${schedule.start_date}</td>
					  		</tr>
					  		<tr>
					  			<th>종료 시간 yyyymmddhh24miss</th>
					 			<td>${schedule.end_date}</td>
					  		</tr>
					  		<tr>
					  			<th>설명</th>
					 			<td>${schedule.description}</td>
					  		</tr>
					  		<tr>
					  			<th>등록자 아이디</th>
					 			<td>${schedule.user_id}</td>
					  		</tr>
					  		<tr>
					  			<th>실행 주체</th>
					 			<td>${schedule.execute_server}</td>
					  		</tr>
					  		<tr>
					  			<th>사용유무</th>
					 			<td>${schedule.use_yn}</td>
					  		</tr>
					  		<tr>
					  			<th>등록일</th>
					 			<td>${schedule.viewRegisterDate}</td>
					  		</tr>
					  		<tr style="line-height: 40px;">
					  			<td colspan="2" style="text-align: center;">
					  				<a href="/schedule/list-schedule.do" class="buttonPro purple">목록</a>
					  			</td>
					  		</tr>
					 	</table>
			 		
			 		</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>

</body>
</html>