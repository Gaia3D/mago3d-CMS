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
								<th class="col-label" scope="row"><spring:message code='role.name'/></th>
								<td class="col-data">${role.role_name}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">Role Key</th>
								<td class="col-data">${role.role_key}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='role.type'/></th>
								<td class="col-data" id="role_type"></td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='role.type.work'/></th>
								<td class="col-data" id="business_type"></td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='role.use.not'/></th>
								<td class="col-data" id="use_yn"></td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='description'/></th>
								<td class="col-data">${role.description}</td>
							</tr>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<a href="/role/list-role.do?${listParameters}" class="button"><spring:message code='list'/></a>
								<a href="/role/modify-role.do?role_id=${role.role_id }" class="button"><spring:message code='modified'/></a>
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
			$("#role_type").text(JS_MESSAGE["user"]);
		}
		
		if('${role.business_type}' == 0) {
			$("#business_type").text(JS_MESSAGE["user"]);
		} else if('${role.business_type}' == 1) {
			$("#business_type").text(JS_MESSAGE["server"]);
		} else if('${role.business_type}' == 2) {
			$("#business_type").text(JS_MESSAGE["account"]);
		}
		
		if('${role.use_yn}' == 'Y') {
			$("#use_yn").text(JS_MESSAGE["use"]);
		} else {
			$("#use_yn").text(JS_MESSAGE["not.use"]);
		}
	});
</script>
</body>
</html>