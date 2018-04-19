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
						<div class="input-header row">
	<c:if test="${userInfo.error_code ne null && userInfo.error_code ne ''}">					
							<div class="list-desc u-pull-left">
								<h6 style="padding-left: 10px; color: red;">* 
		<c:if test="${userInfo.error_code eq 'user.password.exception'}">
									비밀번호 변환 중에 오류가 발생하였습니다.
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.invalid'}">
									패스워드 정책에 부적합 합니다.
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.compare.invalid'}">
									기존 패스워드가 일치하지 않습니다.
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.exception.char'}">
									특수문자 ${policy.password_exception_char } 는 보안 취약성 때문에 패스워드로 사용 할 수 없는 문자 입니다.
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.digit.invalid'}">
									숫자 갯수가 패스워드 정책에 부적합 합니다.
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.upper.invalid'}">
									대문자 갯수가 패스워드 정책에 부적합 합니다.
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.lower.invalid'}">
									소문자 갯수가 패스워드 정책에 부적합 합니다.
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.special.invalid'}">
									특수문자 갯수가 패스워드 정책에 부적합 합니다.
		</c:if>						
		<c:if test="${userInfo.error_code eq 'user.password.continuous.char.invalid'}">
									연속 문자 제한 개수가 패스워드 정책에 부적합 합니다.
		</c:if>		
								</h6>
							</div>
	</c:if>
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						</div>
						<form:form id="userInfo" modelAttribute="userInfo" method="post" action="/user/update-password.do" onsubmit="return check();">
						<table class="input-table scope-row">
							<col class="col-label" />
							<col class="col-input" />
							<tr>
								<th class="col-label" scope="row">
									<form:label path="password">현재 비밀번호</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:password path="password" cssClass="m" />
									<form:errors path="password" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="new_password">새로운 비밀번호</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:password path="new_password" class="m" />
									<span class="table-desc">영문 대문자 ${policy.password_eng_upper_count}, 소문자 ${policy.password_eng_lower_count},
										 숫자 ${policy.password_number_count}, 특수문자 ${policy.password_special_char_count} 자 이상 필수.
										 ${policy.password_min_length} ~ ${policy.password_max_length}자</span>
									<form:errors path="new_password" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="new_password_confirm">비밀번호 확인</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:password path="new_password_confirm" cssClass="m" />
									 	<form:errors path="new_password_confirm" cssClass="error" />
								</td>
							</tr>
						</table>
						
						<div class="button-group">
							<div id="insertServerLink" class="center-buttons">
								<input type="submit" value="변경하기" />
								<a href="/login/login.do" class="button" onclick="return laterChangePasswordConfirm();" >다음에 변경하기</a>
							</div>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	function check() {
		if ($("#password").val() == "") {
			alert("현재 비밀번호를 입력하여 주십시오.");
			$("#password").focus();
			return false;
		}
		if ($("#new_password").val() == "") {
			alert("새로운 비밀번호를 입력하여 주십시오.");
			$("#new_password").focus();
			return false;
		}
		if ($("#new_password_confirm").val() == "") {
			alert("비밀번호 확인을 입력하여 주십시오.");
			$("#new_password_confirm").focus();
			return false;
		}
		if ($("#password").val() == $("#new_password").val()) {
			alert("현재 비밀번호와 일치합니다. ");
			$("#new_password").focus();
			return false;
		}
		if ($("#new_password").val() != $("#new_password_confirm").val()) {
			alert("새로운 비밀번호와 일치하지 않습니다.");
			$("#new_password_confirm").focus();
			return false;
		}	
	}

	function laterChangePasswordConfirm() {
		return confirm("다음에 변경 시 로그인 페이지로 돌아가며 서비스를 사용할 수 없습니다. 비밀번호를 다음에 변경하시겠습니까?");
	}
</script>
</body>

</html>