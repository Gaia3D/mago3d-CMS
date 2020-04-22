<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>비밀번호 변경 | NDTP</title>
	<link rel="shortcut icon" href="/images/favicon.ico">
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
</head>

<body class="sign">
	<div class="site-body">
		<div class="row">
			<div class="container">
				<div class="site-content">
					<div class="">
						<div class="page-content">
							<div class="input-header row">
		<c:if test="${userInfo.errorCode ne null && userInfo.errorCode ne ''}">					
								<div class="list-desc u-pull-left">
									<h6 style="padding-left: 10px; color: red;">* 
			<c:if test="${userInfo.errorCode eq 'user.password.exception'}">
										비밀번호 변환 중에 오류가 발생하였습니다.
			</c:if>
			<c:if test="${userInfo.errorCode eq 'user.password.invalid'}">
										패스워드 정책에 부적합 합니다.
			</c:if>
			<c:if test="${userInfo.errorCode eq 'user.password.compare.invalid'}">
										기존 패스워드가 일치하지 않습니다.
			</c:if>
			<c:if test="${userInfo.errorCode eq 'user.password.exception.char'}">
										특수문자 ${policy.password_exception_char } 는 보안 취약성 때문에 패스워드로 사용 할 수 없는 문자 입니다.
			</c:if>
			<c:if test="${userInfo.errorCode eq 'user.password.digit.invalid'}">
										숫자 갯수가 패스워드 정책에 부적합 합니다.
			</c:if>
			<c:if test="${userInfo.errorCode eq 'user.password.upper.invalid'}">
										대문자 갯수가 패스워드 정책에 부적합 합니다.
			</c:if>
			<c:if test="${userInfo.errorCode eq 'user.password.lower.invalid'}">
										소문자 갯수가 패스워드 정책에 부적합 합니다.
			</c:if>
			<c:if test="${userInfo.errorCode eq 'user.password.special.invalid'}">
										특수문자 갯수가 패스워드 정책에 부적합 합니다.
			</c:if>						
			<c:if test="${userInfo.errorCode eq 'user.password.continuous.char.invalid'}">
										연속 문자 제한 개수가 패스워드 정책에 부적합 합니다.
			</c:if>		
									</h6>
								</div>
		</c:if>
								<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
							</div>
							<form:form id="userInfo" modelAttribute="userInfo" method="post" action="/user/update-password" onsubmit="return check();">
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
										<form:label path="newPassword">새로운 비밀번호</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:password path="newPassword" class="m" />
										<span class="table-desc">영문 대문자 ${policy.passwordEngUpperCount}, 소문자 ${policy.passwordEngLowerCount},
											 숫자 ${policy.passwordNumberCount}, 특수문자 ${policy.passwordSpecialCharCount} 자 이상 필수.
											 ${policy.passwordMinLength} ~ ${policy.passwordMaxLength}자</span>
										<form:errors path="newPassword" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="newPasswordConfirm">비밀번호 확인</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:password path="newPasswordConfirm" cssClass="m" />
										 	<form:errors path="newPasswordConfirm" cssClass="error" />
									</td>
								</tr>
							</table>
							
							<div class="button-group">
								<div id="insertServerLink" class="center-buttons">
									<input type="submit" value="변경하기" />
									<a href="/sign/signin" class="button" onclick="return laterChangePasswordConfirm();" >다음에 변경하기</a>
								</div>
							</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="" style="text-align: center; margin-top: 50px; font-size: 16px;">
		NDTP (c) LX LH Gaia3D, Inc All Rights Reserved
	</div>
	
<script type="text/javascript">
	$(document).ready(function() {
		$("#password").focus();
	});
	
	function check() {
		if ($("#password").val() == "") {
			alert("현재 비밀번호를 입력하여 주십시오.");
			$("#password").focus();
			return false;
		}
		if ($("#newPassword").val() == "") {
			alert("새로운 비밀번호를 입력하여 주십시오.");
			$("#newPassword").focus();
			return false;
		}
		if ($("#newPasswordConfirm").val() == "") {
			alert("비밀번호 확인을 입력하여 주십시오.");
			$("#newPasswordConfirm").focus();
			return false;
		}
		if ($("#password").val() == $("#newPassword").val()) {
			alert("현재 비밀번호와 일치합니다. ");
			$("#newPassword").focus();
			return false;
		}
		if ($("#newPassword").val() != $("#newPasswordConfirm").val()) {
			alert("새로운 비밀번호와 일치하지 않습니다.");
			$("#newPasswordConfirm").focus();
			return false;
		}	
	}

	function laterChangePasswordConfirm() {
		return confirm("다음에 변경 시 로그인 페이지로 돌아가며 서비스를 사용할 수 없습니다. 비밀번호를 다음에 변경하시겠습니까?");
	}
</script>
</body>

</html>