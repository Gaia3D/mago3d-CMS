<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>권한 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
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
						<form:form id="role" modelAttribute="role" method="post" onsubmit="return false;">
						<table class="input-table scope-row" summary="권한 등록 테이블">
						<caption class="hiddenTag">권한 등록</caption>
							<col class="col-label l" />
							<col class="col-input" />
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="roleName">Role 명</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input"><form:input path="roleName" cssClass="l" size="70" /></td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="roleKey">Role Key</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input"><form:input path="roleKey" size="70" /></td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="roleTarget">Role Target</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<select id="roleTarget" name="roleTarget" class="selectBoxClass" >
										<option value="0"> 사용자 사이트 </option>
										<option value="1"> 관리자 사이트 </option>
										<option value="2"> 서버 </option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<form:label path="roleType">Role 유형</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<select id="roleType" name="roleType" class="selectBoxClass" >
										<option value="0"> 사용자 </option>
										<option value="1"> 서버 </option>
										<option value="2"> API </option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<span>사용 유무</span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input radio-set">
									<input type="radio" id="useY" name="useYn" value="Y" />
									<label for="useY">사용</label>&nbsp;&nbsp;
									<input type="radio" id="useN" name="useYn" value="N" />
									<label for="useN">미사용</label>
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row">
									<span>기본사용 유무</span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input radio-set">
									<input type="radio" id="defaultY" name="defaultYn" value="Y" />
									<label for="defaultY">사용</label>&nbsp;&nbsp;
									<input type="radio" id="defaultN" name="defaultYn" value="N" />
									<label for="defaultN">미사용</label>
								</td>
							</tr>
							<tr>
								<th class="col-label l" scope="row"><form:label path="description">설명</form:label></th>
								<td class="col-input"><form:input path="description" cssClass="xl" size="100" /></td>
							</tr>
						</table>
						<div class="button-group">
							<div id="insertRoleLink" class="center-buttons">
								<a href="/role/list" class="button">목록</a>
								<input type="submit" value="저장" onclick="insert();"/>
							</div>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("input[name='useYn']").filter("[value='Y']").prop("checked", true);
	$("input[name='defaultYn']").filter("[value='Y']").prop("checked", true);
});

$("#roleKey").keyup(function(event) {
	var inputValue = $(this).val();
	if(isHangul(inputValue)) {
		alert("Role Key는 영문 및 숫자만 입력 가능 합니다.");
		return;
	}
});

function check() {
	if( $("#roleName").val().trim() === "" ) {
		alert("Role 명을 입력하여 주십시오.");
		$("#roleName").focus();
		return false;
	}
	else if( $("#roleKey").val().trim() === "" ) {
		alert("Role Key를 입력하여 주십시오.");
		$("#roleKey").focus();
		return false;
	}
	else if($("#roleTarget").val() === "") {
		alert("Role Target을 선택하여 주십시오.");
		return false;
	}
	else if( $("#roleType").val() === "") {
		alert("Role 유형을 선택하여 주십시오.");
		return false;
	}
	else if( $("[name=useYn]:checked").val() === "" || $("[name=useYn]:checked").val() === undefined) {
		alert("사용 유무를 선택하여 주십시오.");
		return false;
	}
	else if( $("[name=defaultYn]:checked").val() === "" || $("[name=defaultYn]:checked").val() === undefined ) {
		alert("기본사용 유무를 선택하여 주십시오.");
		return false;
	}
}

var insertRoleFlag = true;
function insert() {
	if(check() === false) return false;

	if(insertRoleFlag) {
		insertRoleFlag = false;
		$.ajax({
			url: "/role/insert",
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: $("#role").serialize(),
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert(JS_MESSAGE["insert"]);
					window.location.reload();
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
				insertRoleFlag = true;
			},
	        error: function(request, status, error) {
	        	// alert message, 세션이 없는 경우 로그인 페이지로 이동 - common.js
	        	ajaxErrorHandler(request);
	        	insertRoleFlag = true;
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