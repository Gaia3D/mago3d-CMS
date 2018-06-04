<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>main | mago3D User</title>
	<link rel="stylesheet" href="/externlib/sufee-template/css/bootstrap.min.css">
	<link rel="stylesheet" href="/externlib/sufee-template/css/font-awesome.min.css">
	<link rel="stylesheet" href="/externlib/sufee-template/css/themify-icons.css">
	<link rel="stylesheet" href="/externlib/sufee-template/scss/style.css">
	<link rel="stylesheet" href="/css/ko/style.css">
</head>
<body>
	
<!-- Left Panel -->
<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
<!-- Left Panel -->

<!-- Right Panel -->
<div id="right-panel" class="right-panel">

	<!-- Header-->
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
    <!-- Header-->

	<!-- Page Header-->
	<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
    <!-- Page Header-->
			
	<div class="content mt-3" style="min-height: 750px;">
		
		<div class="col-sm-6 col-lg-3">
			data upload
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
    <!-- footer -->
</div>
<!-- Right Panel -->

<script src="/externlib/jquery/jquery.js"></script>
<script src="/externlib/sufee-template/js/plugins.js"></script>
<script src="/externlib/sufee-template/js/main.js"></script>

</body>
</html>
