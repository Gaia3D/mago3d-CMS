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
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='user.input.check.box'/></div>
						<div class="tabs">
							<ul>
								<li><a href="#project_tab"><spring:message code='data.project.information'/></a></li>
							</ul>
							<div id="project_tab">
								<form:form id="project" modelAttribute="project" method="post" onsubmit="return false;">
									<form:hidden path="project_id"/>
									<form:hidden path="old_project_key"/>
								<table class="input-table scope-row">
									<col class="col-label" />
									<col class="col-input" />
									<tr>
										<th class="col-label m" scope="row">
											<form:label path="sharing_type">공유 타입</form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<select id="sharing_type" name="sharing_type" class="select" style="height: 30px;">
												<option value="1" disabled="disabled"> 공개 프로젝트 </option>
												<option value="2" disabled="disabled"> 개인 프로젝트 </option>
								          		<option value="3" disabled="disabled"> 공유 프로젝트 </option>
								          		<option value="0" selected="selected"> 공통 프로젝트 </option>
											</select>
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="project_key">Key</form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:hidden path="duplication_value"/>
											<form:input path="project_key" cssClass="m" />
											<input type="button" id="project_duplication_buttion" value="<spring:message code='overlap.check'/>" />
					  						<form:errors path="project_key" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="project_name"><spring:message code='data.project.name'/></form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="project_name" cssClass="m" />
											<form:errors path="project_name" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="view_order"><spring:message code='order'/></form:label>
										</th>
										<td class="col-input">
											<form:input path="view_order" class="m" />
					  						<form:errors path="view_order" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="default_yn"><spring:message code='default.value'/></form:label>
										</th>
										<td class="col-input">
										<spring:message var='basic' code='basic'/>
										<spring:message var='select' code='select'/>
											<form:radiobutton path="default_yn" value="Y" label="${basic}"/>
											<form:radiobutton path="default_yn" value="N" label="${select}" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="use_yn"><spring:message code='status'/></form:label>
										</th>
										<td class="col-input">
										<spring:message var='use' code='use'/>
										<spring:message var='noUse' code='no.use'/>
											<form:radiobutton path="use_yn" value="Y" label="${use}" />
											<form:radiobutton path="use_yn" value="N" label="${noUse}" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="latitude"><spring:message code='latitude'/></form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="latitude" class="m" />
					  						<form:errors path="latitude" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="longitude"><spring:message code='longitude'/></form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="longitude" class="m" />
					  						<form:errors path="longitude" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="height"><spring:message code='height'/></form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="height" class="m" />
					  						<form:errors path="height" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="duration"><spring:message code='movement.time'/></form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="duration" class="m" />
					  						<form:errors path="duration" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="attributes"><spring:message code='properties'/></form:label>
										</th>
										<td class="col-input">
											<form:input path="attributes" class="xl"/>
					  						<form:errors path="attributes" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="description"><spring:message code='description'/></form:label>
										</th>
										<td class="col-input">
											<form:input path="description" class="xl" />
					  						<form:errors path="description" cssClass="error" />
										</td>
									</tr>
								</table>
								
								<div class="button-group">
									<div id="insertProjectLink" class="center-buttons">
										<input type="submit" value="<spring:message code='modified'/>" onclick="updateProject();" />
										<a href="/data/list-project.do" class="button"><spring:message code='list'/></a>
									</div>
								</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script src="/externlib/jquery/jquery.js"></script>
<script src="/externlib/jquery-ui/jquery-ui.js"></script>		
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
		$("input[name='default_yn'][value='N']").prop('checked', true);
		$("input[name='use_yn'][value='Y']").prop('checked', true);
	});
	
	// project key 중복 확인
	$( "#project_duplication_buttion" ).on( "click", function() {
		var projectKey = $("#project_key").val();
		if (projectKey == "") {
			alert(JS_MESSAGE["project.key.empty"]);
			$("#project_key").focus();
			return false;
		}
		var info = $("#project").serialize();
		$.ajax({
			url: "/data/ajax-project-key-duplication-check.do",
			type: "POST",
			data: info,
			cache: false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					if(msg.duplication_value != "0") {
						alert(JS_MESSAGE["project.key.duplication"]);
						$("#project_key").focus();
						return false;
					} else {
						alert(JS_MESSAGE["project.key.enable"]);
						$("#duplication_value").val(msg.duplication_value);
					}
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request,status,error) {
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
    		}
		});
	});
	
	// Project 정보 저장
	var updateProjectFlag = true;
	function updateProject() {
		if (checkProject() == false) {
			return false;
		}
		if(updateProjectFlag) {
			updateProjectFlag = false;
			var info = $("#project").serialize();
			$.ajax({
				url: "/data/ajax-update-project.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["project.update"]);
						$("#old_project_key").val($("#project_key").val());
						$("#duplication_value").val("");
					}
					updateProjectFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateProjectFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	function checkProject() {
		if ($("#project_key").val() == "") {
			alert(JS_MESSAGE["project.key.empty"]);
			$("#project_key").focus();
			return false;
		}
		if($("#project_key").val() !== $("#old_project_key").val()) {
			if($("#duplication_value").val() == null || $("#duplication_value").val() == "") {
				alert(JS_MESSAGE["project.key.duplication_value.check"]);
				return false;
			} else if($("#duplication_value").val() == "1") {
				alert(JS_MESSAGE["project.key.duplication_value.already"]);
				return false;
			}
		}
		if ($("#project_name").val() == "") {
			alert(JS_MESSAGE["project.name.empty"]);
			$("#project_name").focus();
			return false;
		}
		if ($("#latitude").val() == "") {
			alert(JS_MESSAGE["project.latitude.empty"]);
			$("#latitude").focus();
			return false;
		}
		if ($("#longitude").val() == "") {
			alert(JS_MESSAGE["project.longitude.empty"]);
			$("#longitude").focus();
			return false;
		}
		if ($("#height").val() == "") {
			alert(JS_MESSAGE["project.height.empty"]);
			$("#height").focus();
			return false;
		}
		if ($("#duration").val() == "") {
			alert(JS_MESSAGE["project.duration.empty"]);
			$("#duration").focus();
			return false;
		}
	}
</script>
</body>
</html>