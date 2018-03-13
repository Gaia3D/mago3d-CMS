<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/ko/font/font.css" />
	<link rel="stylesheet" href="/images/ko/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/ko/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/ko/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/ko/style.css" />
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
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						</div>
						<form:form id="licenseForm" modelAttribute="licenseForm" method="post" onsubmit="return false;">
							<form:hidden path="mac_address"/>
						<table class="input-table scope-row">
							<col class="col-label l" />
							<col class="col-input" />
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="company_name">회사명</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="company_name" cssClass="m" />
									<form:errors path="company_name" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="server_count">시스템 수</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="server_count" cssClass="m" />
									<form:errors path="server_count" cssClass="error" />
								</td>
							</tr>
									
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="idm_flag">라이선스 정책</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="idm_flag" cssClass="m" />
									<form:errors path="idm_flag" cssClass="error" />
								</td>
							</tr>
									
							<tr>
								<th class="col-label l" scope="row"><span>맥주소</span></th>
								<td class="col-input">${licenseForm.mac_address}</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="license_type">타입</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:select path="license_type" cssClass="select">
										<form:option value="0">정식 라이선스</form:option>
										<form:option value="1">데모용 라이선스</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="license">라이선스</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="license" cssClass="xl" />
									<form:errors path="license" cssClass="error" />
								</td>
							</tr>		
						</table>
						<div class="button-group">
							<div class="center-buttons">
			  					<a href="#" onclick="updateLicense(); return false;" class="button">저장</a>
							</div>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/ko/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/ko/jquery/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="/externlib/ko/jquery-ui/jquery-ui.js"></script>	
<script type="text/javascript" src="/js/ko/common.js"></script>
<script type="text/javascript" src="/js/ko/message.js"></script>
<script type="text/javascript" src="/js/consoleLog.js"></script>
<script type="text/javascript" src="/js/ko/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#license_type").val("${licenseForm.license_type}");
		$( ".select" ).selectmenu();
	});
	
	function check() {
		if ($("#company_name").val() == "") {
			alert("회사명 입력하여 주십시오.");
			$("#company_name").focus();
			return false;
		}
		if ($("#server_count").val() == "") {
			alert("시스템 수를 입력하여 주십시오.");
			$("#server_count").focus();
			return false;
		}
		if ($("#license").val() == "") {
			alert("라이선스를 입력하여 주십시오.");
			$("#license").focus();
			return false;
		}
	}
	
	// 저장
	var updateFlag = true;
	function updateLicense() {
		check();
		if(updateFlag) {
			updateFlag = false;
			var info = $("#licenseForm").serialize();
			$.ajax({
				url : "/config/ajax-update-license.do",
				type : "POST",
				data : info,
				cache : false,
				async : false,
				dataType : "json",
				success : function(msg) {
					if (msg.result == "user.session.does.not.exist") {
						alert(JS_MESSAGE["user.session.empty"]);
					} else if(msg.result == "license.input.invalid") {
						alert(JS_MESSAGE["cache.input.invalid"]);
					} else if (msg.result == "db.exception") {
						alert(JS_MESSAGE["db.exception"]);
					} else if(msg.result == "license.checker.invalid") {
						alert("라이선스 수정에 실패하였습니다.");
					} else if (msg.result == "success") {
						alert("라이선스를 수정 하였습니다.");
					}
					updateFlag = true;
				},
				error : function(request, status, error) {
					alert(JS_MESSAGE["ajax.error.message"]);
					updateFlag = true;
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