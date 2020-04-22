<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>권한 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
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
						<div class="filters">
							<form:form id="searchForm" modelAttribute="role" method="get" action="/role/list" onsubmit="return searchCheck();">
								<div class="input-group row">
									<div class="input-set">
										<label for="searchWord" class="hiddenTag">검색유형</label>
										<select id="searchWord" name="searchWord" class="select" title="검색유형" style="height: 30px;">
											<option value=""><spring:message code='select'/></option>
											<option value="role_name">Role명</option>
										</select>
										<label for="searchOption" class="hiddenTag">검색옵션</label>
										<form:select path="searchOption" class="select" title="검색옵션" style="height: 30px;">
											<form:option value="0"><spring:message code='search.same'/></form:option>
											<form:option value="1"><spring:message code='search.include'/></form:option>
										</form:select>
										<label for="searchValue"><spring:message code='search.word'/></label>
										<form:input path="searchValue" type="search" cssClass="m" cssStyle="float: right;" />
									</div>
									<div class="input-set">
										<label for="startDate"><spring:message code='search.date'/></label>
										<input type="text" class="s date" id="startDate" name="startDate" autocomplete="off" />
										<span class="delimeter tilde">~</span>
										<label for="endDate" class="hiddenTag">종료일</label>
										<input type="text" class="s date" id="endDate" name="endDate" autocomplete="off" />
									</div>
									<div class="input-set">
										<label for="orderWord"><spring:message code='search.order'/></label>
										<select id="orderWord" name="orderWord" class="select" title="표시기준" style="height: 30px;">
											<option value=""><spring:message code='search.basic'/></option>
											<option value="role_name">Role명</option>
											<option value="insert_date"><spring:message code='search.insert.date'/></option>
										</select>
										<label for="orderValue" class="hiddenTag">정렬기준</label>
										<select id="orderValue" name="orderValue" class="select" title="정렬기준" style="height: 30px;">
					                		<option value=""><spring:message code='search.basic'/></option>
						                	<option value="ASC"><spring:message code='search.ascending'/></option>
											<option value="DESC"><spring:message code='search.descending.order'/></option>
										</select>
										<label for="listCounter" class="hiddenTag">리스트건수</label>
										<form:select path="listCounter" class="select" title="리스트건수" style="height: 30px;">
					                		<form:option value="10"><spring:message code='search.ten.count'/></form:option>
						                	<form:option value="50"><spring:message code='search.fifty.count'/></form:option>
											<form:option value="100"><spring:message code='search.hundred.count'/></form:option>
										</form:select>
									</div>
									<div class="input-set">
										<input type="submit" value="<spring:message code='search'/>" />
									</div>
								</div>
							</form:form>
						</div>

						<div class="list">
					    	<div class="list-header row">
								<div class="list-desc u-pull-left">
									전체: <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em> 건,
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
								</div>
								<div class="list-functions u-pull-right">
									<div style="padding-bottom: 3px;" class="button-group">
										<a href="/role/input" class="button" title="권한 등록">권한 등록</a>
									</div>
								</div>
							</div>
							<table class="list-table scope-col" summary="권한 목록 테이블">
							<caption class="hiddenTag">권한 목록</caption>
								<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">Role명</th>
									<th scope="col">Role Key</th>
									<th scope="col">Role Target</th>
									<th scope="col">Role 타입</th>
									<th scope="col">사용유무</th>
									<th scope="col">수정</th>
									<th scope="col">삭제</th>
									<th scope="col">등록일</th>
								</tr>
								</thead>
<c:if test="${empty roleList }">
								<tr>
									<td colspan="9" class="col-none">Role 이 존재하지 않습니다.</td>
								</tr>
</c:if>
<c:if test="${!empty roleList }">
	<c:forEach var="role" items="${roleList}" varStatus="status">
								<tr>
									<td class="col-number">${pagination.rowNumber - status.index}</td>
									<td class="col-name" style="text-align: left;">${role.roleName }</td>
									<td class="col-key" style="text-align: left;">${role.roleKey }</td>
									<td class="col-type">
		<c:if test="${role.roleTarget eq '0' }">
										사용자 사이트
		</c:if>
		<c:if test="${role.roleTarget eq '1' }">
										관리자 사이트
		</c:if>
		<c:if test="${role.roleTarget eq '2' }">
										서버
		</c:if>
									</td>
									<td class="col-type">
		<c:if test="${role.roleType eq '0' }">
										사용자
		</c:if>
		<c:if test="${role.roleType eq '1' }">
										서버
		</c:if>
		<c:if test="${role.roleType eq '2' }">
										api
		</c:if>
									</td>
									<td class="col-toggle">
		<c:if test="${role.useYn eq 'Y' }">
										사용
		</c:if>
		<c:if test="${role.useYn eq 'N' }">
										미사용
		</c:if>
									</td>
									<td class="col-functions">
										<a href="/role/modify?roleId=${role.roleId}" class="linkButton">수정</a>
									</td>
									<td class="col-functions">
		<c:if test="${role.defaultYn eq 'Y' }">
										삭제불가(기본)
		</c:if>
		<c:if test="${role.defaultYn eq 'N' }">
										<a href="#" onclick="deleteRole('${role.roleId}'); return false;" class="linkButton">삭제</a>
		</c:if>
									</td>
									<td class="col-date-time">
										<fmt:parseDate value="${role.insertDate }" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
										<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
								</tr>
	</c:forEach>
</c:if>
							</table>
						</div>
						<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
$(document).ready(function() {
	initDatePicker();

	$("#searchWord").val("${role.searchWord}");
	$("#searchValue").val("${role.searchValue}");
	$("#orderWord").val("${role.orderWord}");
	$("#orderValue").val("${role.orderValue}");

	initCalendar(new Array("startDate", "endDate"), new Array("${role.startDate}", "${role.endDate}"));
});

function searchCheck() {
	if($("#searchOption").val() == "1") {
		if(confirm(JS_MESSAGE["search.option.warning"])) {
			// go
		} else {
			return false;
		}
	}

	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	if(startDate != null && startDate != "" && endDate != null && endDate != "") {
		if(parseInt(startDate) > parseInt(endDate)) {
			alert(JS_MESSAGE["search.date.warning"]);
			$("#startDate").focus();
			return false;
		}
	}
	return true;
}

var deleteRoleFlag = true;
function deleteRole(roleId) {
	if(deleteRoleFlag) {
		if(confirm(JS_MESSAGE["delete.confirm"])) {
			deleteRoleFlag = false;
			$.ajax({
				url: "/role/delete?roleId=" + roleId,
				type: "DELETE",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg) {
					alert(JS_MESSAGE["delete"]);
					location.reload();
				},
		        error: function(request, status, error) {
		        	// alert message, 세션이 없는 경우 로그인 페이지로 이동 - common.js
		        	ajaxErrorHandler(request);
					deleteRoleFlag = true;
		        }
			});
		} else {
			deleteRoleFlag = true;
		}
	} else {
		alert(JS_MESSAGE["button.dobule.click"]);
		return;
	}
}
</script>
</body>
</html>