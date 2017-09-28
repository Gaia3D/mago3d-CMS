<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title><spring:message code='login.page.title' /></title>
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
				<div style="float: right;">
					<select id="userLocale" name="userLocale" onchange="changeLanguage(this.value);">
						<option value="ko">KOREA</option>
						<option value="en">ENGLISH</option>
						<option value="ja">JAPAN</option>
					</select>
				</div>
				<div class="row">
					<h1 style="padding-bottom:10px; font-size:38px; font-family:Lousianne; color:#573592;">mago3D</h1>
<c:if test="${loginForm.error_code ne null && loginForm.error_code ne ''}">
					<h6 style="padding-left: 10px; color: red;">* 
						<spring:message code="${loginForm.error_code}" />
					</h6>
</c:if>
				</div>
				<div class="panel row">
					<h2 class="sign-title"><span class="text-sub">Administrator</span><br /><span class="text-main">Login</span></h2>
					<div class="sign-inputs">
						<div class="sign-desc">Content Management System</div>
						<form:form id="loginForm" modelAttribute="loginForm" method="post" action="/login/process-login.do" onsubmit="return check();">
							<label for="user_id"><span class="icon-glyph glyph-users"></span></label>
							<input type="text" id="user_id" name="user_id" maxlength="32" title="<spring:message code='login.id.title' />" 
							placeholder="<spring:message code='login.id.placeholder' />" required="required" />
							<label for="password"><span class="icon-glyph glyph-lock"></span></label>
							<input type="password" id="password" name="password" maxlength="32" title="<spring:message code='login.password.title' />" 
							placeholder="<spring:message code='login.password.placeholder' />" required="required" />
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
	
	function changeLanguage(lang) {
		var updateFlag = true;
		if(updateFlag) {
			updateFlag = false;
			$.ajax({
				url: "/login/ajax-change-language.do?lang=" + lang,
				type: "GET",
				//data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						//alert(JS_MESSAGE["success"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateFlag = true;
				},
				error:function(request,status,error){
			        //alert(JS_MESSAGE["ajax.error.message"]);
			        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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