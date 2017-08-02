<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>about | mago3D User</title>
	<!--[if lt IE 9]>
	   	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>
<body>
<header></header>
<nav class="nav">
		<div>
			<h1>
				<a href="/homepage/index.do">mago3D</a>
			</h1>
			<ul class="menu">
				<li><a href="/homepage/about.do">mago3D</a></li>
				<li class="mm" onclick='selectMenu();'>Demo<span></span>
					<ul>
						<li><a href="/homepage/demo.do" style="color: white">Cesium</a></li>
						<li><a href="/homepage/demo.do?viewLibrary=worldwind"
							style="color: white">World Wind</a></li>
					</ul>
				</li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li class="on">Documentation<span></span></li>
			</ul>
			<ul class="language">
				<li id="languageKO"><a href="#" onclick="changeLanguage('ko');">KO</a></li>
				<li id="languageEN" class="on">EN</li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="docs-menu">
			<ul>
				<li class="on"><a href="/homepage/docs.do">Docs</a></li>
				<li><a href="/homepage/api.do" target="_blank">mago3D.JS API</a></li>
				<li><a href="#"  onclick='alert("준비 중 입니다."); return false;'>F4D-Converter Spec</a>
			</ul>
		</div>
		<div class="docs-main">
			<div class="title">Documentation</div>
			<p>MAGO3D integrates AEC (Architecture, Engineering, Construction) area and 3D spatial information (3D GIS) and delivers images. MAGO3D integrates AEC and 3D GIS with web servers. MAGO3D users can install Building Information Modeling (BIM), Jupiter Tessellation (JT), and 3D GIS files together with other programs to help collaborate.</p>
			<div class="sub_title">API Reference Documentation</div>
			<ul class="docs-list">
				<li><a href="/homepage/api.do">mago3D.JS API</a>Is a document describing the API for JavaScript.</li>
			</ul>
		</div>
	</section>
	<footer style="margin-top: 67px;">
	<div>
		<h2>
			Contact <span></span>
		</h2>
		<p>mago3D 에 관심있는 고객들께서는 연락(이메일, 전화) 또는 직접 방문을 부탁드립니다.</p>
		<ul class="contact">
			<li class="company">www.gaia3d.com</li>
			<li class="address">+82-(0)2-3397-3475</li>
			<li class="mail">info@gaia3d.com</li>
		</ul>
		<p class="copyright">&copy; 2017 Gaia3D, Inc.</p>
	</div>
	</footer>
</body>

</html>