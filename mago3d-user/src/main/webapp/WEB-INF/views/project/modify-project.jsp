<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>프로젝트 수정 | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css?cache_version=${cache_version}">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/cloud.js?cache_version=${cache_version}"></script>
</head>
<body>

<div class="site-body">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<div id="site-content" class="on">
		<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
		<div id="content-wrap">
			<div id="gnb-content" class="clfix">
				<h1 style="padding-left: 20px;">
					<span style="font-size:26px;">프로젝트 수정</span>
				</h1>
				<div class="location">
					<span style="padding-top:10px; font-size:12px; color: Mediumslateblue;">
						<i class="fas fa-cubes" title="프로젝트"></i>
					</span>
					<span style="font-size:12px;">프로젝트 > 프로젝트 수정</span>
				</div>
			</div>
				
			<!-- Start content by page -->
			<div class="page-content">
				<div class="content-desc u-pull-right" style="padding-right: 10px;">
					<span class="icon-glyph glyph-emark-dot color-warning" style="display: inline-block; padding-bottom: 2px;"></span>
					<span style="display: inline-block; padding-bottom: 2px;"><spring:message code='check'/></span></div>
				<div style="margin-top: 20px; border: 1px solid #dddddd;">
					<ul style="list-style: none; font-size: 14px; border-bottom: 3px solid #573592">
						<li style="padding-left: 10px; padding-top: 5px; width: 115px; height: 30px; color: white; background: #573690;">
							<spring:message code='project.information'/>
						</li>
					</ul>
					<div id="project_tab">
						<form:form id="project" modelAttribute="project" method="post" onsubmit="return false;">
							<form:hidden path="project_id"/>
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
										<option value="1" selected="selected"> 공개 프로젝트 </option>
										<option value="2" disabled="disabled"> 개인 프로젝트 </option>
						          		<option value="3" disabled="disabled"> 공유 프로젝트 </option>
						          		<option value="0" disabled="disabled"> 공통 프로젝트 </option>
									</select>
								</td>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="project_name"><spring:message code='project.name'/></form:label>
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
								<a href="/project/list-project.do?${listParameters}" class="button"><spring:message code='list'/></a>
							</div>
						</div>
						</form:form>
					</div>
				</div>
			</div>
			<!-- End content by page -->
			
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>
	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
		$("input[name='default_yn'][value='N']").prop('checked', true);
		$("input[name='use_yn'][value='Y']").prop('checked', true);
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
				url: "/project/ajax-update-project.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["project.update"]);
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