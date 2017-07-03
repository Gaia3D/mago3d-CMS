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
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/${lang}/gibberish-aes.js"></script>
</head>
<body class="sign">
	<div class="site-body">
		<div class="row">
			<div class="container">
				<div class="row">
					<h1 style="padding-bottom:10px; font-size:38px; font-family:Lousianne; color:#573592;">mago3D</h1>
<c:if test="${loginForm.error_code ne null && loginForm.error_code ne ''}">
					<h6 style="padding-left: 10px; color: red;">* 
	<c:if test="${loginForm.error_code eq 'user.session.empty'}">
						고객 정보가 존재하지 않습니다. 아이디, 비밀번호를 확인하여 주십시오.
	</c:if>
	<c:if test="${loginForm.error_code eq 'usersession.password.invalid'}">
		<c:if test="${loginForm.status == null || loginForm.status == ''}">
						비밀번호가 일치하지 않습니다.
		</c:if>
		<c:if test="${loginForm.status != null && loginForm.status != ''}">
						비밀번호가 일치하지 않습니다. <br/>현재 고객님은 ${loginForm.viewStatus} 상태 입니다. 관리자에게 문의하여 주십시요.
		</c:if>
	</c:if>
	<c:if test="${loginForm.error_code eq 'usersession.status.invalid'}">
						현재 고객님은 ${loginForm.viewStatus} 상태 입니다. 관리자에게 문의하여 주십시요.
	</c:if>
	<c:if test="${loginForm.error_code eq 'usersession.faillogincount.invalid'}">
						고객님은 비밀번호 실패 횟수 ${loginForm.fail_login_count } 를 초과하셨습니다. <br/>
						관리자에게 문의하여 주십시요.
	</c:if>
	<c:if test="${loginForm.error_code eq 'usersession.lastlogin.invalid'}">
						고객님은 마지막 로그인 ${loginForm.viewLastLoginDate } 로 부터 ${loginForm.user_last_login_lock }일이 경과 되었습니다.<br/>
						관리자에게 문의하여 주십시요.
	</c:if>
	<c:if test="${loginForm.error_code eq 'login.encrypt.exception'}">
						로그인 정보 복호화 처리 과정에서 오류가 발생하였습니다. <br/>페이지를 새로고침 후 이용해 주시기 바랍니다.
	</c:if>
	<c:if test="${loginForm.error_code eq 'usersession.role.invalid'}">
						관리자 페이지 접근 권한(ROLE)이 존재하지 않습니다.
	</c:if>
	<c:if test="${loginForm.error_code eq 'userdevice.ip.invalid'}">
						사용자 등록 정보에 저장된 IP가 아닙니다.
	</c:if>
					</h6>
</c:if>				
				</div>
				<div class="panel row">
					<h2 class="sign-title"><span class="text-sub">Administrator</span><br /><span class="text-main">Login</span></h2>
					<div class="sign-inputs">
						<div class="sign-desc">mago3D 이슈 시스템</div>
						<form:form id="loginForm" modelAttribute="loginForm" method="post" action="/login/process-login.do" onsubmit="return check();">
							<input type="hidden" name="login_type" value=""/>
							<label for="user_id"><span class="icon-glyph glyph-users"></span></label>
							<input type="text" id="user_id" name="user_id" maxlength="32" title="아이디" placeholder="아이디" required="required" />
							<label for="password"><span class="icon-glyph glyph-lock"></span></label>
							<input type="password" id="password" name="password" maxlength="32" title="패스워드" placeholder="패스워드" required="required" />
							<input type="submit" value="Sign In" class="sign-submit" />
						</form:form>					
						<div class="sign-links">
							Don't have an account? &nbsp;<a href="#">Sign up</a>
							<br />
							Forgot your password? &nbsp;<a href="/login/find-password.do">Click</a>
						</div>
					</div>
				</div>
			</div>
			<div class="" style="text-align: center; margin-top: 50px;">
				Mago3D ⓒ Gaia3d Corp. All Rights Reserved
			</div>
 		</div>
	</div>
	
<script type="text/javascript">
	$(document).ready(function () {
	});
	
	function check() {
		if ($("#user_id").val() == "") {
			alert(JS_MESSAGE["user.id.empty"]);
			$("#user_id").focus();
			return false;
		}
		
		if ($("#password").val() == "") {
			alert(JS_MESSAGE["password.empty"]);
			$("#password").focus();
			return false;
		}
		
		/* GibberishAES.size(128);	
		var encryptionPassword = GibberishAES.aesEncrypt($("#password").val(), "${TOKEN_AES_KEY}");
		alert("encryptionPassword = " + encryptionPassword + ", password = " + encodeURIComponent(encryptionPassword));
		$("#password").val(encodeURIComponent(encryptionPassword)); */
	}
</script>
</body>
</html>