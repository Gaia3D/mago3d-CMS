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
						<div class="filters">
							<form:form id="issue" modelAttribute="issue" method="post" action="/issue/list-issue.do" onsubmit="return searchCheck();">
							<div class="input-group row">
								<div class="input-set">
									<label for="search_word">검색어</label>
									<select id="search_word" name="search_word" class="select">
										<option value="">선택</option>
										<option value="user_id">아이디</option>
										<option value="title">제목</option>
									</select>
									<select id="search_option" name="search_option" class="select">
										<option value="0">일치</option>
										<option value="1">포함</option>
									</select>
									<form:input path="search_value" cssClass="m" />
								</div>
								<div class="input-set">
									<label for="use_yn">상태</label>
									<select id="use_yn" name="use_yn" class="select">
										<option value="">전체</option>
										<option value="Y">사용</option>
										<option value="N">사용안함</option>
									</select>
								</div>
								<div class="input-set">
									<label for="start_date">기간</label>
									<input type="text" id="start_date" name="start_date" class="s date" />
									<span class="delimeter tilde">~</span>
									<input type="text" id="end_date" name="end_date" class="s date" />
								</div>
								<div class="input-set">
									<label for="order_word">표시순서</label>
									<select id="order_word" name="order_word" class="select">
										<option value="">기본</option>
										<option value="user_id">아이디</option>
										<option value="user_name">이름</option>
										<option value="register_date">등록일</option>
									</select>
									<select id="order_value" name="order_value" class="select">
										<option value="">기본</option>
										<option value="ASC">오름차순</option>
										<option value="DESC">내림차순</option>
									</select>
								</div>
								<div class="input-set">
									<input type="submit" value="검색" />
								</div>
							</div>
							</form:form>
						</div>
						
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									전체: <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em>건, 
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
								</div>
								<div class="list-functions u-pull-right">
									<a href="/issue/input-issue.do" class="image-button button-area button-new" title="새로 등록">새로 등록</a>
								</div>
							</div>
							<table class="list-table scope-col">
								<col class="col-number" />
								<col class="col-id" />
								<col class="col-name" />
								<col class="col-toggle" />
								<col class="col-title" />
								<col class="col-toggle" />
								<col class="col-toggle" />
								<col class="col-toggle" />
								<col class="col-date-time" />
								<col class="col-date-time" />
								<col class="col-functions" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-number">번호</th>
										<th scope="col" class="col-id">아이디</th>
										<th scope="col" class="col-name">이름</th>
										<th scope="col" class="col-toggle">데이터 그룹</th>
										<th scope="col" class="col-title">제목</th>
										<th scope="col" class="col-toggle">우선순위</th>
										<th scope="col" class="col-toggle">유형</th>
										<th scope="col" class="col-toggle">상태</th>
										<th scope="col" class="col-date-time">등록일</th>
										<th scope="col" class="col-date-time">마감일</th>
										<th scope="col" class="col-functions">지도보기</th>
										<th scope="col" class="col-functions">수정 / 삭제</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty issueList }">
							<tr>
								<td colspan="12" class="col-none">Issue이 존재하지 않습니다.</td>
							</tr>
</c:if>
<c:if test="${!empty issueList }">
	<c:forEach var="issue" items="${issueList}" varStatus="status">
									<tr>
										<td class="col-number">${pagination.rowNumber - status.index}</td>
										<td class="col-id">${issue.user_id}</td>
										<td class="col-name">${issue.user_name}</td>
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
										<td class="col-functions">
											<span class="button-group">
												<a href="/issue/modify-issue.do?issue_id=${issue.issue_id}&amp;pageNo=${pagination.pageNo}${pagination.searchParameters}" class="image-button button-edit">수정</a>
												<a href="/issue/delete-issue.do?issue_id=${issue.issue_id }" onclick="return deleteWarning();" class="image-button button-delete">삭제</a>
											</span>	
										</td>
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
		initJqueryCalendar();
		
		initSelect(	new Array("search_word", "search_option", "search_value", "order_word", "order_value"), 
			new Array("${issue.search_word}", "${issue.search_option}", "${issue.search_value}", "${issue.order_word}", "${issue.order_value}"));
		//initCalendar(new Array("start_date", "end_date"), new Array("${issue.start_date}", "${issue.end_date}"));
		$( ".select" ).selectmenu();
	});
	
	function deleteWarning() {
		if(confirm("삭제 하시겠습니까?")) {
			return true;
		} else {
			return false;
		}
	}
	
	/* $( "#search_option" ).selectmenu({
		change: function( event, ui ) {
			if($("#search_option").val() == "1") {
				alert(JS_MESSAGE["search.option.warning"]);
			}
		}
	}); */
	
	/* function searchCheck() {
		if($("#search_option").val() == "1") {
			if(confirm(JS_MESSAGE["search.option.warning"])) {
				// go
			} else {
				return false;
			}
		} 
		
		var start_date = $("#start_date").val();
		var end_date = $("#end_date").val();
		if(start_date != null && start_date != "" && end_date != null && end_date != "") {
			if(parseInt(start_date) > parseInt(end_date)) {
				alert(JS_MESSAGE["search.date.warning"]);
				$("#start_date").focus();
				return false;
			}
		}
		return true;
	} */
</script>
</body>
</html>