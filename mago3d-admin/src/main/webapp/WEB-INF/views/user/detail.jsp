<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 상세 정보 | mago3D</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
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
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						<div class="tabs">
							<ul>
								<li><a href="#userInfoTab"><spring:message code='user.input.information'/></a></li>
								<%-- <li><a href="#userDeviceTab"><spring:message code='user.input.device'/></a></li> --%>
							</ul>
							<div id="userInfoTab">
								<table class="inner-table scope-row">
									<col class="col-label" />
									<col class="col-data" />
									<tr>
										<th class="col-label" scope="row"><spring:message code='user.group.name'/></th>
										<td class="col-data">${userInfo.userGroupName}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='user.id'/></th>
										<td class="col-data">${userInfo.userId}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='name'/></th>
										<td class="col-data">${userInfo.userName}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='status'/></th>
										<td class="col-data">
											<c:if test="${userInfo.status eq '0' }">사용중</c:if>
											<c:if test="${userInfo.status eq '1' }">사용중지</c:if>
											<c:if test="${userInfo.status eq '2' }">잠금</c:if>
											<c:if test="${userInfo.status eq '3' }">휴면</c:if>
											<c:if test="${userInfo.status eq '4' }">만료</c:if>
											<c:if test="${userInfo.status eq '5' }">삭제</c:if>
											<c:if test="${userInfo.status eq '6' }">임시비밀번호</c:if>
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='password'/></th>
										<td class="col-data">********</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="button-group">
							<div class="center-buttons">
								<a href="/user/list?${listParameters}" class="button"><spring:message code='list'/></a>
								<a href="/user/modify?userId=${userInfo.userId}&amp;${listParameters}" class="button"><spring:message code='modified'/></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<%-- F4D Converter Job 등록 --%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
	});
</script>
</body>
</html>
