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
						<table class="inner-table scope-row">
							<col class="col-label" />
							<col class="col-data" />
							<tr>
								<th class="col-label" scope="row">Role 명</th>
								<td class="col-data">${role.role_name}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">Role Key</th>
								<td class="col-data">${role.role_key}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">Role 유형</th>
								<td class="col-data" id="role_type"></td>
							</tr>
							<tr>
								<th class="col-label" scope="row">업무 유형</th>
								<td class="col-data" id="business_type"></td>
							</tr>
							<tr>
								<th class="col-label" scope="row">사용 유무</th>
								<td class="col-data" id="use_yn"></td>
							</tr>
							<tr>
								<th class="col-label" scope="row">설명</th>
								<td class="col-data">${role.description}</td>
							</tr>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<a href="/role/list-role.do?${listParameters}" class="button">목록</a>
								<a href="/role/modify-role.do?role_id=${role.role_id }" class="button">수정</a>
							</div>
						</div>
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
<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".select" ).selectmenu();
		
		if('${role.role_type}' == 0) {
			$("#role_type").text("사용자");
		}
		
		if('${role.business_type}' == 0) {
			$("#business_type").text("사용자");
		} else if('${role.business_type}' == 1) {
			$("#business_type").text("서버");
		} else if('${role.business_type}' == 2) {
			$("#business_type").text("계정");
		}
		
		if('${role.use_yn}' == 'Y') {
			$("#use_yn").text("사용");
		} else {
			$("#use_yn").text("미사용");
		}
	});
</script>
</body>
</html>