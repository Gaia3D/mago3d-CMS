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
					
					<div>
						<c:if test="${method_mode eq 'insert'}"><spring:message code='issue.insert'/></c:if><br>
						<c:if test="${method_mode eq 'update'}"><spring:message code='issue.modify'/></c:if><br>
						<c:if test="${method_mode eq 'delete'}"><spring:message code='issue.delete'/></c:if><br>
					</div>
					
					<table class="input-table scope-row">

							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.project_name'/></th>
					 			<td>${issue.project_name}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.type'/></th>
					 			<td>${issue.issue_type}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.name'/></th>
					 			<td>${issue.title}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.priority'/></th>
					 			<td>${issue.priority}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.insert.date'/></th>
					 			<td>${issue.viewInsertDate}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.due.date'/></th>
					 			<td>${issue.due_date}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.status'/></th>
					 			<td>${issue.status}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.latitude'/></th>
					 			<td>${issue.latitude}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.longitude'/></th>
					 			<td>${issue.longitude}</td>
							</tr>
							
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.assignee'/></th>
					 			<td>${issue.assignee}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.reporter'/></th>
					 			<td>${issue.reporter}</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='issue.comment'/></th>
					 			<td>${issue.comment}</td>
							</tr>
							
						</table>
							
						<div class="button-group">
							<div id="insertIssueLink" class="center-buttons">
								<a href="/issue/list-issue.do" class="button"><spring:message code='list' /></a>
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

</body>
</html>