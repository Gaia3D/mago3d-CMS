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
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN"><a href="#" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="docs-menu">
			<ul>
				<li class="on"><a href="/homepage/docs.do">Docs</a></li>
				<li><a href="#"  onclick='alert("준비 중 입니다."); return false;'>Tutorials</a>
				<li><a href="/homepage/api.do">mago3D.JS API</a></li>
				<li><a href="#"  onclick='alert("준비 중 입니다."); return false;' >Rendering API</a>
				<li><a href="#"  onclick='alert("준비 중 입니다."); return false;'>F4D-Converter Spec</a>
				
			</ul>
		</div>
		<div class="docs-main">
			<div class="title">Documentation</div>
			<p>mago3D 참조 문서 페이지입니다.</p>
			<div class="sub_title">Tutorials</div>
			<ul class="docs-list">
				<li>준비 중 입니다.</li>
			</ul>
			<div class="sub_title">API Reference Documentation</div>
			<ul class="docs-list">
				<li><a href="/homepage/api.do">mago3D.JS API</a>는 JavaScript에 관한 API를 설명한 문서입니다.</li>
				<li><a href="#" onclick='alert("준비 중 입니다.")'>Rendering API</a>는 Server Rendering에 관한 API를 설명한 문서입니다.</li>
			</ul>
			<div class="sub_title">F4D-Converter Spec?</div>
			<ul class="docs-list">
				<li><a href="#" onclick='alert("준비 중 입니다.")'>F4D-Converter Spec</a>을 정의한 문서입니다.</li>
			</ul>
		</div>
	</section>
	<footer style="margin-top: 160px;">
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