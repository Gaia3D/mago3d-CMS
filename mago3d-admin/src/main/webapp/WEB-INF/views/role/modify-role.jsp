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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="role" modelAttribute="role" method="post" onsubmit="return false;">
							<form:hidden path="role_id"/>
							<form:hidden path="role_key"/>
						<table class="input-table scope-row">
							<col class="col-label l" />
							<col class="col-input" />
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="role_name"><spring:message code='role.name'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input"><form:input path="role_name" cssClass="l" /></td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									Role Key
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">${role.role_key}</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="role_type"><spring:message code='role.type'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<spring:message code='role.user' var='user'/>
								<spring:message code='role.server' var='server'/>
								<td class="col-input">
									<select id="role_type" name="role_type" class="select" >
										<option value="0"> ${user} </option>
										<option value="1"> ${server} </option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row"><form:label path="business_type">업무 유형</form:label></th>
								<spring:message code='role.login' var='login'/>
								<spring:message code='role.main' var='main'/>
								<td class="col-input">
									<select id="business_type" name="business_type" class="select">
										<option value="0"> ${login} </option>
										<option value="1"> ${main} </option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<span><spring:message code='role.use.not'/></span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<spring:message code='use' var='use'/>
								<spring:message code='not.use' var='notUse'/>
								<td class="col-input radio-set">
									<form:radiobutton path="use_yn" value="Y" />
									<label for="role-usage-use">${use}</label>
									<form:radiobutton path="use_yn" value="N" />
									<label for="role-usage-none">${notUse}</label>
								</td>
							</tr>
						  	<tr>
								<th class="col-label l" scope="row"><form:label path="description"><spring:message code='description'/></form:label></th>
								<td class="col-input"><form:input path="description" cssClass="xl" /></td>
							</tr>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="updateRole();" />
								<a href="/role/list-role.do?pageNo=${pagination.pageNo }" class="button"><spring:message code='list'/></a>
							</div>
						</div>
						</form:form>
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
		$( ".select" ).selectmenu();
	});
	
	function check() {
		if ($("#role_name").val() == "") {
			alert(JS_MESSAGE["role.insert.name"]);
			$("#role_name").focus();
			return false;
		}
		if ($("#role_type").val() == "") {
			alert(JS_MESSAGE["role.insert.type"]);
			$("#role_type").focus();
			return false;
		}
	}
	
	// 수정
	var updateRoleFlag = true;
	function updateRole() {
		if (check() == false) {
			return false;
		}
		if(updateRoleFlag) {
			updateRoleFlag = false;
			var info = $("#role").serialize();		
			$.ajax({
				url: "/role/ajax-update-role.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateRoleFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateRoleFlag = true;
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