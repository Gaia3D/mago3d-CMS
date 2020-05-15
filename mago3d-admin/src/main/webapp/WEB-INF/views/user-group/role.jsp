<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 그룹 Role | mago3D</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css" />
    <style type="text/css">
    	.title {
			font-size: 15px;
			font-weight: bold;
			color: black;
    	}
    </style>
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
							<form:form id="userGroupRole" modelAttribute="userGroupRole" method="post" onsubmit="return false;">
								<input type="hidden" id="checkIds" name="checkIds" value="" />
								<div class="">
							    	<div style="float: left; padding: 5px; width: 100%;">
										<div style="float: left; width: 50%; ">
											사용자 그룹명: <span class="title">${userGroup.userGroupName }</span>
										</div>
									</div>
									<table class="list-table scope-col">
										<thead>
											<tr>
												<th scope="col"><input type="checkbox" id="chkAll" name="chkAll" /></th>
												<th scope="col">Role Target</th>
												<th scope="col">Role 타입</th>
												<th scope="col">Role명</th>
												<th scope="col">Role Key</th>
												<th scope="col">사용 유무</th>
												<th scope="col">기본 사용 유무</th>
												<th scope="col">설명</th>
											</tr>
										</thead>
										<c:if test="${empty roleList }">
											<tr>
												<td colspan="8" class="col-none">Role이 존재하지 않습니다.</td>
											</tr>
										</c:if>
										<c:if test="${!empty roleList }">
											<c:forEach var="role" items="${roleList}" varStatus="status">
											<tr>
												<td class="col-checkbox">
													<input type="checkbox" id="roleId${role.roleId}" name="roleId" value="${role.roleId}" />
												</td>
												<td class="col-type">
													<c:if test="${role.roleTarget eq '0'}">사용자 사이트</c:if>
													<c:if test="${role.roleTarget eq '1'}">관리자 사이트</c:if>
													<c:if test="${role.roleTarget eq '2'}">서버</c:if>
												</td>
												<td class="col-type">
													<c:if test="${role.roleType eq '0'}">사용자</c:if>
													<c:if test="${role.roleType eq '1'}">서버</c:if>
													<c:if test="${role.roleType eq '2'}">API</c:if>
												</td>
												<td class="col-id" style="text-align: left;">${role.roleName }</td>
												<td class="col-name" style="text-align: left;">${role.roleKey }</td>
												<td class="col-type">${role.useYn }</td>
												<td class="col-type">${role.defaultYn }</td>
												<td class="col-id">${role.description }</td>
											</tr>
											</c:forEach>
										</c:if>
									</table>
								</div>
								<div class="button-group">
									<div class="center-buttons">
										<input type="submit" value="<spring:message code='save'/>" onclick="update();"/>
										<a href="/user-group/list" class="button">목록</a>
									</div>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var userGroupRoleJson = JSON.parse('${userGroupRoleJson}');
		for(var i=0; i<userGroupRoleJson.length; i++) {
			var userGroupRole = userGroupRoleJson[i];
			var roleId = userGroupRole.roleId;
			$("input:checkbox[id='roleId" + roleId + "']").prop("checked", true);
		}
	});

	//전체 선택
	$("#chkAll").click(function() {
		$(":checkbox[name=roleId]").prop("checked", this.checked);
	});

	var updateUserGroupRoleFlag = true;
	function update() {
		if($("input:checkbox[name=roleId]:checked").length == 0) {
			alert(JS_MESSAGE["check.value.required"]);
			return false;
		}
		var checkedValue = "";
		$("input:checkbox[name=roleId]:checked").each(function(index){
			checkedValue += $(this).val() + ",";
		});
		$("#checkIds").val(checkedValue);

		if(updateUserGroupRoleFlag) {
			updateUserGroupRoleFlag = false;

			$.ajax({
    			url: "/user-groups/role",
    			type: "POST",
    			headers: {"X-Requested-With": "XMLHttpRequest"},
    	        data: {userGroupId: "${userGroup.userGroupId}", checkIds: $("#checkIds").val()},
    			success: function(msg){
    				if(msg.statusCode <= 200) {
    					alert(JS_MESSAGE["update"]);
    					window.location.reload();
    					updateUserGroupRoleFlag = true;
    				} else {
						alert(JS_MESSAGE[msg.errorCode]);
    					console.log("---- " + msg.message);
    					updateUserGroupRoleFlag = true;
    				}
    			},
    			error:function(request, status, error){
    		        alert(JS_MESSAGE["ajax.error.message"]);
    		        downFlag = true;
    			}
    		});
		} else {
			alert("진행 중입니다.");
			return;
		}
	}
</script>
</body>
</html>