<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Mago3D User</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
</head>

<body class="general-user">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<div class="site-body">
		<div class="container">
			<div class="row">
				<div class="page-header row">
					<h2 class="page-title u-pull-left">개인 통계 정보</h2>
				</div>
			</div>
			<div class="row">
				<div class="personal-stats day column">
					<div class="row">
						<div class="stats-symbol u-pull-left">
							<span class="icon-glyph glyph-calendar-day"></span>
						</div>
						<div class="stats-content u-pull-left">
							<h5 class="personal-stats-title">금일 Issue 건수</h5>
							<div class="personal-stats-content">
								<span id="today_certification_count" class="large-text">로딩중</span>
								<span id="today_certification_count_label" class="medium-text">...</span>
							</div>
						</div>
					</div>
					<div class="stats-rate row">
						<span class="text">진행중</span>
						<span class="bar"></span>
						<span id="today_certification_success_count" class="number">0</span>
						<span class="text">완료</span>
						<span class="bar"></span>
						<span id="today_certification_fail_count" class="number">0</span>
					</div>
				</div>
				<div class="personal-stats month column">
					<div class="row">
						<div class="stats-symbol u-pull-left">
							<span class="icon-glyph glyph-calendar"></span>
						</div>
						<div class="stats-content u-pull-left">
							<h5 class="personal-stats-title">금월 Issue 건수</h5>
							<div class="personal-stats-content">
								<span id="month_certification_count" class="large-text">로딩중</span>
								<span id="month_certification_count_label" class="medium-text">...</span>
							</div>
						</div>
					</div>
					<div class="stats-rate row">
						<span class="text">진행중</span>
						<span class="bar"></span>
						<span id="month_certification_success_count" class="number">0</span>
						<span class="text">완료</span>
						<span class="bar"></span>
						<span id="month_certification_fail_count" class="number">0</span>
					</div>
				</div>
				<div class="personal-stats method column">
					<div class="row">
						<div class="stats-symbol u-pull-left">
							<span class="icon-glyph glyph-pc"></span>
						</div>
						<div class="stats-content u-pull-left">
							<h5 class="personal-stats-title">Upload 파일수</h5>
							<div class="personal-stats-content">
								<span class="large-text">미사용</span>
								<span class="medium-text"></span>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			
			<div class="row">
				<div class="page-header row">
					<h2 class="page-title u-pull-left">Issue  현황</h2>
				</div>
				<div class="list">
					<div class="list-header row">
						<div class="list-desc u-pull-left">
							전체: <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em>건, 
							<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
						</div>
					</div>
					<table class="list-table scope-col">
						<col class="col-number" />
						<col class="col-name" />
						<col class="col-name" />
						<col class="col-toggle" />
						<col class="col-toggle" />
						<col class="col-toggle" />
						<col class="col-date-time" />
						<col class="col-date-time" />
						<col class="col-functions" />
						<thead>
							<tr>
								<th scope="col" class="col-number">번호</th>
								<th scope="col" class="col-toggle">데이터 그룹</th>
								<th scope="col" class="col-title">제목</th>
								<th scope="col" class="col-toggle">우선순위</th>
								<th scope="col" class="col-toggle">유형</th>
								<th scope="col" class="col-toggle">상태</th>
								<th scope="col" class="col-date-time">등록일</th>
								<th scope="col" class="col-date-time">마감일</th>
								<th scope="col" class="col-functions">지도보기</th>
							</tr>
						</thead>
						<tbody id="userIssueList">
<c:if test="${empty issueList }">
							<tr>
								<td colspan="9" class="col-none">Issue가 존재하지 않습니다.</td>
							</tr>
</c:if>
<c:if test="${!empty issueList }">
	<c:forEach var="issue" items="${issueList}" varStatus="status">
									<tr>
										<td class="col-number">${pagination.rowNumber - status.index}</td>
										<td class="col-toggle">${issue.data_group_name}</td>
										<td class="col-title">
											<a href="/issue/detail-issue.do?issue_id=${issue.issue_id}&amp;pageNo=${pagination.pageNo}${pagination.searchParameters}">${issue.title}</a>
											<span class="table-desc">
												&nbsp;&nbsp;[조회:${issue.view_count}]
		<c:if test="${issue.comment_count > 0 }">
												&nbsp;&nbsp;[답글:${issue.comment_count}]
		</c:if>
											</span>
										</td>
										<td class="col-toggle">${issue.priority}</td>
										<td class="col-toggle">${issue.issue_type}</td>
										<td class="col-toggle">${issue.status}</td>
										<td class="col-period">${issue.viewInsertDate}</td>
										<td class="col-date-time">${issue.viewDueDate}</td>
										<td class="col-functions">[보기]</td>
									</tr>
	</c:forEach>
</c:if>	
						</tbody>
					</table>
				</div>
				
				<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/externlib/${lang}/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/${lang}/spinner/raphael.js"></script>
<script type="text/javascript">
	
</script>
</body>
</html>
