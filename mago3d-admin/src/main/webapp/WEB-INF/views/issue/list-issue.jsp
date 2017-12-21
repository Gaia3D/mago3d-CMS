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
									<label for="search_word"><spring:message code='search.word'/></label>
									<select id="search_word" name="search_word" class="select">
										<option value=""><spring:message code='select'/></option>
										<option value="user_id"><spring:message code='id'/></option>
										<option value="title"><spring:message code='title'/></option>
									</select>
									<select id="search_option" name="search_option" class="select">
										<option value="0"><spring:message code='search.same'/></option>
										<option value="1"><spring:message code='search.include'/></option>
									</select>
									<form:input path="search_value" cssClass="m" />
								</div>
								<div class="input-set">
									<label for="use_yn"><spring:message code='status'/></label>
									<select id="use_yn" name="use_yn" class="select">
										<option value=""><spring:message code='all'/></option>
										<option value="Y"><spring:message code='use'/></option>
										<option value="N"><spring:message code='no.use'/></option>
									</select>
								</div>
								<div class="input-set">
									<label for="start_date"><spring:message code='term'/></label>
									<input type="text" id="start_date" name="start_date" class="s date" />
									<span class="delimeter tilde">~</span>
									<input type="text" id="end_date" name="end_date" class="s date" />
								</div>
								<div class="input-set">
									<label for="order_word"><spring:message code='search.order'/></label>
									<select id="order_word" name="order_word" class="select">
										<option value=""><spring:message code='search.basic'/></option>
										<option value="user_id"><spring:message code='id'/></option>
										<option value="user_name"><spring:message code='name'/></option>
										<option value="register_date"><spring:message code='search.insert.date'/></option>
									</select>
									<select id="order_value" name="order_value" class="select">
										<option value=""><spring:message code='search.basic'/></option>
										<option value="ASC"><spring:message code='search.ascending'/></option>
										<option value="DESC"><spring:message code='search.descending.order'/></option>
									</select>
								</div>
								<div class="input-set">
									<input type="submit" value="<spring:message code='search'/>"/>
								</div>
							</div>
							</form:form>
						</div>
						
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/>
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
								</div>
								<div class="list-functions u-pull-right">
									<a href="/issue/input-issue.do" class="image-button button-area button-new" title="<spring:message code='new.insert'/>"><spring:message code='new.insert'/></a>
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
										<th scope="col" class="col-number"><spring:message code='number'/></th>
										<th scope="col" class="col-id"><spring:message code='id'/></th>
										<th scope="col" class="col-name"><spring:message code='name'/></th>
										<th scope="col" class="col-toggle">프로젝트명</th>
										<th scope="col" class="col-title"><spring:message code='title'/></th>
										<th scope="col" class="col-toggle"><spring:message code='user.device.priority'/></th>
										<th scope="col" class="col-toggle"><spring:message code='type'/></th>
										<th scope="col" class="col-toggle"><spring:message code='status'/></th>
										<th scope="col" class="col-date-time"><spring:message code='search.insert.date'/></th>
										<th scope="col" class="col-date-time"><spring:message code='deadline'/></th>
										<th scope="col" class="col-functions"><spring:message code='look.map'/></th>
										<th scope="col" class="col-functions"><spring:message code='user.group.modified.and.insert'/></th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty issueList }">
							<tr>
								<td colspan="12" class="col-none"><spring:message code='issue.no.issue'/></td>
							</tr>
</c:if>
<c:if test="${!empty issueList }">
	<c:forEach var="issue" items="${issueList}" varStatus="status">
									<tr>
										<td class="col-number">${pagination.rowNumber - status.index}</td>
										<td class="col-id">${issue.user_id}</td>
										<td class="col-name">${issue.user_name}</td>
										<td class="col-toggle">${issue.project_name}</td>
										<td class="col-title">
											<a href="/issue/detail-issue.do?issue_id=${issue.issue_id}&amp;pageNo=${pagination.pageNo}${pagination.searchParameters}">${issue.title}</a>
											<span class="table-desc">
												&nbsp;&nbsp;[<spring:message code='data.group.lookup'/>:${issue.view_count}]
		<c:if test="${issue.comment_count > 0 }">
												&nbsp;&nbsp;[<spring:message code='issue.reply'/>:${issue.comment_count}]
		</c:if>
											</span>
										</td>
										<td class="col-toggle">${issue.priority}</td>
										<td class="col-toggle">${issue.issue_type}</td>
										<td class="col-toggle">${issue.status}</td>
										<td class="col-period">${issue.viewInsertDate}</td>
										<td class="col-date-time">${issue.viewDueDate}</td>
										<td class="col-functions">[<spring:message code='look'/>]</td>
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