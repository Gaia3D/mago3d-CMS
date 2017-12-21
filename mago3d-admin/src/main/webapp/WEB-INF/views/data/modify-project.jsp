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
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='user.input.check.box'/></div>
						<div class="tabs">
							<ul>
								<li><a href="#project_tab">프로젝트 정보</a></li>
							</ul>
							<div id="project_tab">
								<form:form id="project" modelAttribute="project" method="post" onsubmit="return false;">
									<form:hidden path="project_id"/>
									<form:hidden path="old_project_key"/>
								<table class="input-table scope-row">
									<col class="col-label" />
									<col class="col-input" />
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
											<form:label path="project_name">프로젝트명</form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="project_name" cssClass="m" />
											<form:errors path="project_name" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="view_order">순서</form:label>
										</th>
										<td class="col-input">
											<form:input path="view_order" class="m" />
					  						<form:errors path="view_order" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="default_yn">기본값</form:label>
										</th>
										<td class="col-input">
											<form:radiobutton path="default_yn" value="Y" label="기본"/>
											<form:radiobutton path="default_yn" value="N" label="선택" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="use_yn">사용유무</form:label>
										</th>
										<td class="col-input">
											<form:radiobutton path="use_yn" value="Y" label="사용" />
											<form:radiobutton path="use_yn" value="N" label="사용안함" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="latitude"><spring:message code='lat'/></form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="latitude" class="m" />
					  						<form:errors path="latitude" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="longitude"><spring:message code='lon'/></form:label>
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
											<form:label path="duration">이동시간</form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="duration" class="m" />
					  						<form:errors path="duration" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="description">설명</form:label>
										</th>
										<td class="col-input">
											<form:input path="description" class="xl" />
					  						<form:errors path="description" cssClass="error" />
										</td>
									</tr>
								</table>
								
								<div class="button-group">
									<div id="insertProjectLink" class="center-buttons">
										<input type="submit" value="수정" onclick="updateProject();" />
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
	
<script src="/externlib/${lang}/jquery/jquery.js"></script>
<script src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>		
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
			//async:false,
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