<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 목록 | NDTP</title>
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
						<div class="filters">
							<form:form id="searchForm" modelAttribute="userInfo" method="get" action="/user/list" onsubmit="return searchCheck();">
								<div class="input-group row">
									<div class="input-set">
											<label for="searchWord" class="hiddenTag">검색유형</label>
											<select id="searchWord" name="searchWord" title="검색유형" class="select" style="height: 30px;">
												<option value=""><spring:message code='select'/></option>
							          			<option value="user_id">아이디</option>
							          			<option value="user_name">사용자명</option>
							          			<option value="user_group_name">그룹명</option>
							          			<option value="status">상태</option>
											</select>
											<label for="searchOption" class="hiddenTag">검색옵션</label>
											<form:select path="searchOption" title="검색옵션" class="select" style="height: 30px;">
												<form:option value="0"><spring:message code='search.same'/></form:option>
												<form:option value="1"><spring:message code='search.include'/></form:option>
											</form:select>
											<label for="searchValue"><spring:message code='search.word'/></label>
											<form:input path="searchValue" type="search" cssClass="m" cssStyle="float: right;" />

									</div>
									<div class="input-set">
										<label for="startDate"><spring:message code='search.date'/></label>
										<input type="text" class="s date" id="startDate" name="startDate" title="시작일" autocomplete="off" />
										<span class="delimeter tilde">~</span>
										<label for="endDate" class="hiddenTag">종료일</label>
										<input type="text" class="s date" id="endDate" name="endDate" title="종료일" autocomplete="off" />
									</div>
									<div class="input-set">
										<label for="orderWord"><spring:message code='search.order'/></label>
										<select id="orderWord" name="orderWord" title="정렬유형" class="select" style="height: 30px;">
											<option value=""><spring:message code='search.basic'/></option>
						          			<option value="user_id">아이디</option>
											<option value="user_name">사용자명</option>
						          			<option value="user_group_name">그룹명</option>
						          			<option value="status">상태</option>
						          			<option value="last_signin_date">마지막 로그인</option>
											<option value="insert_date"><spring:message code='search.insert.date'/></option>
										</select>
										<label for="orderValue" class="hiddenTag">정렬기준</label>
										<select id="orderValue" name="orderValue" title="정렬기준" class="select" style="height: 30px;">
					                		<option value=""><spring:message code='search.basic'/></option>
						                	<option value="ASC"><spring:message code='search.ascending'/></option>
											<option value="DESC"><spring:message code='search.descending.order'/></option>
										</select>
										<label for="listCounter" class="hiddenTag">결과건수</label>
										<form:select path="listCounter" class="select" title="결과건수" style="height: 30px;">
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
							<form:form id="listForm" modelAttribute="userInfo" method="post">
								<input type="hidden" id="checkIds" name="checkIds" value="" />
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/>
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
								</div>
								<div class="list-functions u-pull-right">
									<div style="padding-bottom: 3px;" class="button-group">
										<a href="#" onclick="updateUserStatus('LOCK'); return false;" class="button">
											<spring:message code='user.group.user.lock'/></a>
										<a href="#" onclick="updateUserStatus('UNLOCK'); return false;" class="button">
											<spring:message code='user.group.user.lock.init'/></a>
									</div>
									<!-- <div style="padding-bottom: 3px;" class="button-group">
										<a href="#" onclick="return false;" class="button">비밀번호 초기화</a>
										<a href="#" onclick="return false;" class="button">사용자 잠금</a>
										<a href="#" onclick="return false;" class="button">사용자 잠금 해제</a>
										<a href="#" onclick="return false;" class="button">일괄삭제</a>
										<a href="#" onclick="return false;" class="button">일괄등록(EXCEL)</a>
										<a href="#" onclick="return false;" class="button">다운로드(EXCEL)</a>
									</div> -->
								</div>
							</div>
							<table class="list-table scope-col" summary="사용자 목록 조회 ">
							<caption class="hiddenTag">사용자 목록</caption>
								<col class="col-checkbox" />
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-type" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-checkbox"><label for="chkAll" class="hiddenTag"></label><input type="checkbox" id="chkAll" name="chkAll" /></th>
										<th scope="col" class="col-number"><spring:message code='number'/></th>
										<th scope="col"><spring:message code='user.group.name'/></th>
					                    <th scope="col">아이디</th>
					                    <th scope="col">이름</th>
					                    <th scope="col">상태</th>
					                    <th scope="col">마지막 로그인</th>
					                    <th scope="col">편집</th>
					                    <th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty userList}">
									<tr>
										<td colspan="9" class="col-none">사용자 목록이 존재하지 않습니다.</td>
									</tr>
</c:if>
<c:if test="${!empty userList}">
	<c:forEach var="user" items="${userList}" varStatus="status">

									<tr>
										<td class="col-checkbox">
											<label for="userId_${user.userId}" class="hiddenTag"></label>
											<input type="checkbox" id="userId_${user.userId}" name="userId" value="${user.userId}" />
										</td>
										<td class="col-number">${pagination.rowNumber - status.index}</td>
										<td class="col-name ellipsis">
											<a href="#" class="view-group-detail" onclick="detailUserGroup('${user.userGroupId}'); return false;">${user.userGroupName }</a>
										</td>
										<td class="col-name">${user.userId}</td>
										<td class="col-name">
											<a href="/user/detail?userId=${user.userId}&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}" class="linkButton">${user.userName}</a>
										</td>
										<td class="col-type">
											<c:choose>
												<c:when test="${user.status eq '0'}">
													<span class="icon-glyph glyph-on on" style="margin-right:3px;"></span>
													<span class="icon-text"><spring:message code='user.group.in.use' /></span>
												</c:when>
												<c:when test="${user.status eq '1'}">
													<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
													<span class="icon-text"><spring:message code='user.group.stop.use'/></span>
												</c:when>
												<c:when test="${user.status eq '2'}">
													<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
													<span class="icon-text"><spring:message code='user.group.lock.password'/></span>
												</c:when>
												<c:when test="${user.status eq '3'}">
													<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
													<span class="icon-text"><spring:message code='user.group.dormancy'/></span>
												</c:when>
												<c:when test="${user.status eq '4'}">
													<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
													<span class="icon-text"><spring:message code='user.group.expires'/></span>
												</c:when>
												<c:when test="${user.status eq '5'}">
													<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
													<span class="icon-text"><spring:message code='user.group.delete'/></span>
												</c:when>
												<c:when test="${user.status eq '6'}">
													<span class="icon-glyph glyph-off off" style="margin-right:3px;"></span>
													<span class="icon-text"><spring:message code='user.group.temporary.password'/></span>
												</c:when>
											</c:choose>
										</td>
										<td class="col-type">
											<fmt:parseDate value="${user.lastSigninDate}" var="viewLastSigninDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewLastSigninDate}" pattern="yyyy-MM-dd HH:mm"/>
										</td>
					                    <td class="col-type">
											<a href="/user/modify?userId=${user.userId}" class="image-button button-edit"><spring:message code='modified'/></a>&nbsp;&nbsp;
					                    	<a href="/user/delete?userId=${user.userId}" onclick="return deleteWarning();" class="image-button button-delete"><spring:message code='delete'/></a>
					                    </td>
										<td class="col-type">
											<fmt:parseDate value="${user.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
										</td>
									</tr>
	</c:forEach>
</c:if>
								</tbody>
							</table>
							</form:form>

						</div>
						<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/user-group/dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initDatePicker();

		$("#searchWord").val("${userInfo.searchWord}");
		$("#searchValue").val("${userInfo.searchValue}");
		$("#orderWord").val("${userInfo.orderWord}");
		$("#orderValue").val("${userInfo.orderValue}");

		initCalendar(new Array("startDate", "endDate"), new Array("${userInfo.startDate}", "${userInfo.endDate}"));
	});

	//전체 선택
	$("#chkAll").click(function() {
		$(":checkbox[name=userId]").prop("checked", this.checked);
	});

	// 사용자 그룹 정보
	var userGroupDialog = $("#userGroupInfoDialog").dialog({
		autoOpen: false,
		width: 700,
		height: 400,
		modal: true,
		resizable: false
	});

	// 사용자 그룹 정보
	function detailUserGroup(userGroupId) {
		userGroupDialog.dialog("open");

		$.ajax({
			url: "/user-groups/detail",
			data: {"userGroupId": userGroupId},
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					$("#userGroupNameInfo").html(msg.userGroup.userGroupName);
					$("#userGroupKeyInfo").html(msg.userGroup.userGroupKey);
					$("#basicInfo").html(msg.userGroup.basic?'기본':'선택');
					$("#availableInfo").html(msg.userGroup.available?'사용':'미사용');
					$("#descriptionInfo").html(msg.userGroup.description);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error: function(request, status, error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 사용자 잠금, 사용자 잠금 해제
	var updateUserStatusFlag = true;
	function updateUserStatus(statusValue) {
		if($("input:checkbox[name=userId]:checked").length == 0) {
			alert(JS_MESSAGE["check.value.required"]);
			return false;
		} else {
			var checkedValue = "";
			$("input:checkbox[name=userId]:checked").each(function(index){
				checkedValue += $(this).val() + ",";
			});
			$("#checkIds").val(checkedValue);
		}

		if(updateUserStatusFlag) {
			updateUserStatusFlag = false;
			$.ajax({
				url: "/users/status",
				type: "POST",
				data: {checkIds: checkedValue, statusValue: statusValue},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["update"]);
						location.reload();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
					}
					updateUserStatusFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserStatusFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

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
</script>
</body>
</html>
