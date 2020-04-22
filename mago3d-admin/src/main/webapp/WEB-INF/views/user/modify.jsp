<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 수정 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/dropzone/dropzone.min.css?cacheVersion=${contentCacheVersion}">
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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="userInfo" modelAttribute="userInfo" method="post" onsubmit="return false;">
						<table class="input-table scope-row" summary="사용자 정보 등록 테이블">
						<caption class="hiddenTag">사용자 등록</caption>
							<col class="col-label" />
							<col class="col-input" />
			                <tr>
								<th class="col-label" scope="row">
									<form:label path="userGroupName"><spring:message code='user.group.name'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:hidden path="userGroupId" />
									<form:input path="userGroupName" cssClass="l" readonly="true" />
									<input type="button" id="userGroupButton" value="사용자 그룹 선택" />
								</td>
							</tr>
			                <tr>
								<th class="col-label" scope="row">
									<form:label path="userId"><spring:message code='user.id'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="userId" cssClass="m" readonly="true" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
			                        <form:label path="userName"><spring:message code='name'/></form:label>
			                        <span class="icon-glyph glyph-emark-dot color-warning"></span>
			                    </th>
			                    <td class="col-input">
									<form:input path="userName" cssClass="m"/>
								</td>
			                    <%-- <td class="col-input radio-set">
			                        <form:radiobutton id="sharingPublic"  path="sharing" value="public" label="공개" />
									<form:radiobutton id="sharingPrivate" path="sharing" value="private" label="비공개" />
									<form:radiobutton id="sharingGroup" path="sharing" value="group" label="그룹" />
			                    </td> --%>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="password"><spring:message code='password'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:password path="password" class="m" />
									<span class="table-desc"><spring:message code='user.input.upper.case'/> ${policy.passwordEngUpperCount}, <spring:message code='user.input.lower.case'/> ${policy.passwordEngLowerCount},
										 <spring:message code='user.input.number'/> ${policy.passwordNumberCount}, <spring:message code='user.input.special.characters'/> ${policy.passwordSpecialCharCount} <spring:message code='user.input.special.characters.need'/>
										 ${policy.passwordMinLength} ~ ${policy.passwordMaxLength}<spring:message code='user.input.do'/></span>
									<form:errors path="password" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="passwordConfirm"><spring:message code='password.check'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:password path="passwordConfirm" class="m" />
									<form:errors path="passwordConfirm" cssClass="error" />
								</td>
							</tr>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="update();"/>
								<%-- <a href="/user/detail?userId=${userInfo.userId}" class="button">목록</a> --%>
								<a href="/user/list" class="button">목록</a>
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

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#password').val('');
		$('#passwordConfirm').val('');
	});

	var userGroupDialog = $("#userGroupListDialog").dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 사용자 그룹 선택
	$("#userGroupButton").on("click", function() {
		userGroupDialog.dialog("open");
		userGroupDialog.dialog("option", "title", "사용자 그룹 선택");
	});

	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#userGroupId").val(parent);
		$("#userGroupName").val(parentName);
		userGroupDialog.dialog( "close" );
	}

	function check() {
		var passwordValidation = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!#^%*?&])[A-Za-z\d$@$!#^%*?&]{${policy.passwordMinLength},${policy.passwordMaxLength}}$/;

		if(!$("#userGroupId").val()) {
			alert(JS_MESSAGE["user.group.select"]);
			$("#userGroupId").focus();
			return false;
		}
		if (!$("#userName").val()) {
			alert(JS_MESSAGE["user.name.empty"]);
			$("#userName").focus();
			return false;
		}
		if (!$("#password").val()) {
			alert(JS_MESSAGE["password.empty"]);
			$("#password").focus();
			return false;
		} else if(!passwordValidation.test($("#password").val())) {
			alert(JS_MESSAGE["user.password.invalid"]);
			$("#password").focus();
			return false;
		} else if($("#passwordConfirm").val() == "") {
			alert(JS_MESSAGE["password.correct.empty"]);
			$("#passwordConfirm").focus();
			return false;
		} else if($("#password").val() !== $("#passwordConfirm").val()) {
			alert("입력한 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			$("#passwordConfirm").focus();
			return false;
		}
	}

	// 저장
	var updateUserFlag = true;
	function update() {
		if (check() == false) {
			return false;
		}
		if(updateUserFlag) {
			updateUserFlag = false;
			var formData = $("#userInfo").serialize();
			$.ajax({
				url: "/users/update",
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
					updateUserFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserFlag = true;
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