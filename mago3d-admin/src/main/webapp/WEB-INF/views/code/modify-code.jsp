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
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						</div>
						<form:form id="commonCode" modelAttribute="commonCode" method="post" onsubmit="return false;">
							<form:hidden path="code_key" />
							<form:hidden path="db_code_value" />
						<table class="input-table scope-row">
							<col class="col-label l" />
							<col class="col-input" />
							<tr>
								<th class="col-label l" scope="row">
									코드키
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">${commonCode.code_key}</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="code_name">코드명</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input"><form:input path="code_name" cssClass="m" /></td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="code_name_en">코드명(영어)</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input"><form:input path="code_name_en" cssClass="m" /></td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="code_value">코드값</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input"><form:input path="code_value" cssClass="m" /></td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="code_type">코드분류</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input"><form:input path="code_type" cssClass="m" /></td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<span>사용 여부</span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input radio-set">
							 		<form:radiobutton path="use_yn" value="Y" label="사용" />
									<form:radiobutton path="use_yn" value="N" label="사용안함" />
								</td>
									
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="view_order">표시순서</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input"><form:input path="view_order" cssClass="s" /></td>
							</tr>
							<tr>
								<th class="col-label l" scope="row"><form:label path="description">설명</form:label></th>
								<td class="col-input"><form:input path="description" cssClass="xl" /></td>
							</tr>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="저장" onclick="updateCode();" />
								<a href="/code/list-code.do" class="button">목록</a>
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
		if ($("#code_name").val() == "") {
			alert("코드명을 입력하여 주십시오.");
			$("#code_name").focus();
			return false;
		}
		if ($("#code_value").val() == "") {
			alert("코드값을 선택해 주십시오.");
			$("#code_value").focus();
			return false;
		}
	}
	
	// 수정
	var updateCodeFlag = true;
	function updateCode() {
		if (check() == false) {
			return false;
		}
		if(updateCodeFlag) {
			updateCodeFlag = false;
			var info = $("#commonCode").serialize();		
			$.ajax({
				url: "/code/ajax-update-code.do",
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
					updateCodeFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateCodeFlag = true;
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