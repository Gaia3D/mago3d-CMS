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
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									전체: <em>${totalCount}</em>건
								</div>
							</div>
							<table class="list-table scope-col">
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-key" />
								<col class="col-desc" />
								<col class="col-toggle" />
								<col class="col-date-time" />
								<col class="col-date-time" />
								<col class="col-type" />
								<col class="col-id" />
								<col class="col-desc" />
								<col class="col-date-time" />
								<!-- <col class="col-functions" /> -->
								<thead>
									<tr>
										<th scope="col" class="col-number">번호</th>
										<th scope="col" class="col-name">스케줄명</th>
										<th scope="col" class="col-key">스케줄 KEY</th>
										<th scope="col" class="col-desc">표현식</th>
										<th scope="col" class="col-toggle">사용유무</th>
										<th scope="col" class="col-date-time">시작시간</th>
										<th scope="col" class="col-date-time">종료시간</th>
										<th scope="col" class="col-type">실행주체</th>
										<th scope="col" class="col-id">등록자</th>
										<th scope="col" class="col-desc">설명</th>
										<th scope="col" class="col-date-time">등록일</th>
										<!-- <th scope="col" class="col-functions">수정</th> -->
									</tr>
								</thead>
								<tbody>
<c:if test="${empty scheduleList }">
								<tr>
									<td colspan="11" class="col-none">스케줄 목록이 존재하지 않습니다.</td>
								</tr>
</c:if>
<c:if test="${!empty scheduleList }">
	<c:forEach var="schedule" items="${scheduleList}" varStatus="status">
									<tr>
										<td class="col-number">${status.index + 1}</td>
										<td class="col-name">${schedule.schedule_name}</td>
										<td class="col-key">${schedule.schedule_code}</td>
										<td class="col-desc">${schedule.expression}</td>
										<td class="col-toggle">${schedule.viewUseYn}</td>
										<td class="col-date-time">${schedule.start_date}</td>
										<td class="col-date-time">${schedule.end_date}</td>
										<td class="col-type">${schedule.viewExecuteType}</td>
										<td class="col-id">${schedule.user_id}</td>
										<td class="col-desc">${schedule.description}</td>
										<td class="col-date-time">${aPILog.viewRegisterDate }</td>
										<%-- <td class="col-type">
											<span class="button-group">
												<a href="/schedule/modify-schedule.do?schedule_id=${schedule.schedule_id}" class="image-button button-edit">수정</a>
											</span>
										</td> --%>
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
	
<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/externlib/jquery/jquery.form.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});
</script>
</body>
</html>