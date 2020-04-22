<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Sign In | NDTP</title>
	<link rel="shortcut icon" href="/images/favicon.ico?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/style.css?cacheVersion=${contentCacheVersion}" />
	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
	<style type="text/css">
		::placeholder { /* Chrome, Firefox, Opera, Safari 10.1+ */
			color: white;
			opacity: 1; /* Firefox */
		}
		:-ms-input-placeholder { /* Internet Explorer 10-11 */
			color: white;
		}
		::-ms-input-placeholder { /* Microsoft Edge */
			color: white;
		}	
	</style>
</head>
<body class="sign">
	<div class="site-body">
		<div class="row">
			<div class="container">
				<div class="row">
					<h1 style="margin-bottom: 10px; font-size:38px; font-family:Lousianne; color:#573592;">NDTP</h1>
<c:if test="${signinForm.errorCode ne null && signinForm.errorCode ne ''}">
					<h6 style="padding-left: 10px; color: red;">* 
						<spring:message code="${signinForm.errorCode}" />
					</h6>
</c:if>
				</div>
				<div class="panel row">
					<h2 class="sign-title"><span class="text-sub">사용자</span><br /><span class="text-main">SIGN IN</span></h2>
					<div class="sign-inputs">
						<div class="sign-desc" style="font-size: 16px; margin-top: 10px; margin-right: 25px;">National Digital Twin Platform Pilot Service</div>
						
						<form:form id="signinForm" modelAttribute="signinForm" method="post" action="/sign/process-signin">
							<label for="userId"><span class="icon-glyph glyph-users"></span></label>
							<input type="text" id="userId" name="userId" maxlength="32" title="아이디" placeholder="아이디" required="required" autofocus="autofocus" />
							<label for="password"><span class="icon-glyph glyph-lock"></span></label>
							<input type="password" id="password" name="password" maxlength="32" title="비밀번호" placeholder="비밀번호" required="required" />
							<input type="submit" value="Sign In" class="sign-submit" />
						</form:form>					
						<!-- <div class="sign-links" style="font-size: 16px;">
							Don't have an account? &nbsp;<a href="#" onclick="alert('관리자에게 문의하여 주십시오.'); return false;">Sign up</a>
						</div> -->
					</div>
				</div>
			</div>
			<div class="" style="text-align: center; margin-top: 50px; font-size: 16px;">
				NDTP (c) LX LH Gaia3D, Inc All Rights Reserved
			</div>
 		</div>
	</div>
	
<script type="text/javascript">
</script>
</body>
</html>