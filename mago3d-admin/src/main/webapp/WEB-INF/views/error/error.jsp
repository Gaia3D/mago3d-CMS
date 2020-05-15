<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>오류 | mago3D</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/css/${lang}/admin-style.css" />
</head>

<body class="general-user">
	
	<div class="site-body">
		<div class="container">
			<div class="row">
				<div class="page-header row">
					<h2 class="page-title u-pull-left">오류 페이지(${httpStatusCode })</h2>
				</div>
				<div class="marT40"></div>
				<div class="list">
					<div style="float:left; margin-right:40px; padding-left: 20px;"><img src="/images/ko/common/error.png" width="130" height="130" /></div>
			        <div style="font-size:22px; padding-top: 30px;"><b>요청하신 페이지를 찾을 수 없습니다.</b></div>
			        <div style="margin-top:10px;">브라우저 주소 입력란을 다시 한번 확인해 주십시오. &nbsp;&nbsp;<a href="/main/index" class="button">홈</a></div>
				</div>
				<div class="marT40"></div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>

</body>
</html>
