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
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em>${totalCount}</em> <spring:message code='search.what.count'/>
								</div>
							</div>
							<table class="list-table scope-col">
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-type" />
								<col class="col-ip" />
								<col class="col-url" />
								<col class="col-toggle" />
								<col class="col-date-time" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-number"><spring:message code='number'/></th>
										<th scope="col" class="col-name"><spring:message code='api.service.name'/></th>
										<th scope="col" class="col-type"><spring:message code='api.service.type'/></th>
										<th scope="col" class="col-ip">IP</th>
										<th scope="col" class="col-url">URL</th>
										<th scope="col" class="col-toggle"><spring:message code='status'/></th>
										<th scope="col" class="col-date-time"><spring:message code='search.insert.date'/></th>
										<th scope="col" class="col-functions"><spring:message code='modified'/></th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty externalServiceList }">
								<tr>
									<td colspan="8" class="col-none"><spring:message code='api.no.api'/></td>
								</tr>
</c:if>
<c:if test="${!empty externalServiceList }">
	<c:forEach var="externalService" items="${externalServiceList}" varStatus="status">
									<tr>
										<td class="col-number">${status.index + 1}</td>
										<td class="col-name">${externalService.service_name}</td>
										<td class="col-type">
	<c:if test="${externalService.service_type eq '0' }">
											Cache(캐시 Reload
	</c:if>
	<c:if test="${externalService.service_type eq '1' }">
											OTP 서버
	</c:if>
	<c:if test="${externalService.service_type eq '2' }">
											고가용성(HA)
	</c:if>
	<c:if test="${externalService.service_type eq '3' }">
											접속자 목록
	</c:if>							
										</td>
										<td class="col-ip">${externalService.server_ip}</td>
										<td class="col-url">${externalService.url_scheme}://${externalService.url_host}:${externalService.url_port}/${externalService.url_path}</td>
										<td class="col-toggle">${externalService.viewStatus}</td>
										<td class="col-date-time">${externalService.viewInsertDate}</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="/api/modify-external-service.do?external_service_id=${externalService.external_service_id}" class="image-button button-edit">수정</a>
											</span>
										</td>
									</tr>
	</c:forEach>
</c:if>													
								</tbody>
							</table>
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