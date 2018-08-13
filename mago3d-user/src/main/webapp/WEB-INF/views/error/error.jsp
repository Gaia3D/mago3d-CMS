<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>main | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<script type="text/javascript" src="/js/cloud.js"></script>
</head>
<body>

<div class="default-layout">
	<!-- 왼쪽 메뉴 -->
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<!-- 왼쪽 메뉴 -->
	
	<!--  컨텐츠 -->
	<div class="content-layout">
		<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
		<div>
			<div class="content-gnb">
				<div class="page-header row" style="padding-left: 40px; padding-top: 15px; padding-right: 40px;">
					<h2 class="page-title u-pull-left">
						오류 페이지(404)
					</h2>
				</div>
			</div>
			
			<div class="content-detail">
				<div class="container">
					<div class="row">
						<div style="background-color: #fff; height: 40px;"></div>
						<div class="list">
							<div style="float:left; margin-right:40px; padding-left: 50px;"><img src="/images/ko/common/error.png" width="130" height="130" /></div>
					        <div style="font-size:22px; padding-top: 30px;"><b>요청하신 페이지를 찾을 수 없습니다.</b></div>
					        <div style="margin-top:10px;">브라우저 주소 입력란을 다시 한번 확인해 주십시오. &nbsp;&nbsp;<a href="/main/index.do" class="button">홈</a></div>
						</div>
						<div class="marT40"></div>
					</div>
				</div>
			</div>
			
			<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
		</div>
	</div>
	<!--  컨텐츠 -->
</div>

<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/js/${lang }/message.js"></script>
</body>
</html>
