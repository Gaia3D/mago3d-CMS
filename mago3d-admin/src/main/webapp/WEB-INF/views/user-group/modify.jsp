<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 그룹 수정 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css" />
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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="userGroup" modelAttribute="userGroup" method="post" onsubmit="return false;">
						<form:hidden path="userGroupId"/>
						<table class="input-table scope-row" summary="사용자 그룹 수정 테이블">
						<caption class="hiddenTag">사용자 그룹 수정</caption>
							<col class="col-label" />
							<col class="col-input" />
							<tr>
								<th class="col-label" scope="row">
									<form:label path="userGroupName">사용자 그룹명</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="userGroupName" cssClass="l" />
									<form:errors path="userGroupName" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="userGroupKey">사용자 그룹 Key</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="userGroupKey" cssClass="l" readonly="true"/>
									<form:errors path="userGroupKey" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="parentName">상위 그룹</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:hidden path="parent" />
		 							<form:input path="parentName" cssClass="l" readonly="true" />
									<!-- <input type="button" id="userGroupButton" value="상위 그룹 선택" /> -->
								</td>
							</tr>
							<tr>
								<th class="col-label m" scope="row">
									<span>기본 여부</span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input radio-set">
									<form:radiobutton label="기본" path="basic" value="true" />
									<form:radiobutton label="선택" path="basic" value="false" />
									<form:errors path="basic" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label m" scope="row">
									<span>사용여부</span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input radio-set">
									<form:radiobutton label="사용" path="available" value="true" />
									<form:radiobutton label="미사용" path="available" value="false" />
									<form:errors path="available" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label m" scope="row"><form:label path="description"><spring:message code='description'/></form:label></th>
								<td class="col-input">
									<form:input path="description" cssClass="xl" />
									<form:errors path="description" cssClass="error" />
								</td>
							</tr>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="updateUserGroup();"/>
								<a href="/user-group/list" class="button">목록</a>
							</div>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/user-group/dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});

	function validate() {
		var number = /^[0-9]+$/;
		if ($("#userGroupName").val() === null || $("#userGroupName").val() === "") {
			alert("사용자 그룹명을 입력해 주세요.");
			$("#userGroupName").focus();
			return false;
		}
		if($("#parent").val() === null || $("#parent").val() === "" || !number.test($("#parent").val())) {
			alert("상위 레이어 그룹을 선택해 주세요.");
			$("#parent").focus();
			return false;
		}
	}

	var userGroupDialog = $("#userGroupListDialog").dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 상위 사용자 그룹 찾기
	$( "#userGroupButton" ).on( "click", function() {
		userGroupDialog.dialog("open" );
		userGroupDialog.dialog("option", "title", "사용자 그룹 선택");
	});

	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#parent").val(parent);
		$("#parentName").val(parentName);
		userGroupDialog.dialog( "close" );
	}

	$( "#rootParentSelect" ).on( "click", function() {
		$("#parent").val(0);
		$("#parentName").val("${userGroup.parentName}");
		userGroupDialog.dialog("close");
	});

	// 저장
	var updateUserGroupFlag = true;
	function updateUserGroup() {
		if (validate() == false) {
			return false;
		}
		if(updateUserGroupFlag) {
			updateUserGroupFlag = false;
			var formData = $("#userGroup").serialize();
			$.ajax({
				url: "/user-groups/update",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["update"]);
						window.location.reload();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					updateUserGroupFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserGroupFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
</script>
</body>
</html>