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
				<li><a href="/homepage/api.do" target="_blank">mago3D.JS API</a></li>
				<li><a href="#"  onclick='alert("준비 중 입니다."); return false;'>F4D-Converter Spec</a>
			</ul>
		</div>
		<div class="docs-main">
			<div class="title">Documentation</div>
			<p>mago3D는 AEC(Architecture, Engineering, Construction) 영역과 전통적인 3차원 공간정보(3D GIS)를 통합적으로 관리, 가시화해 주는 차세대 3차원 플랫폼입니다. 
				mago3D는 기존의 솔루션과 달리 실내외 구별 없이 끊김 없이 AEC와 3D GIS를 웹 브라우저에서 통합해 줍니다. 
				이에 따라, mago3D 사용자는 초대용량 BIM(Building Information Modelling), JT(Jupiter Tessellation), 3D GIS 파일 등을 별도의 프로그램 설치 없이 웹 브라우저 상에서 바로 살펴보고 협업작업을 진행할 수 있습니다.</p>
			<div class="sub_title">mago3D 아키텍처</div>
			<div>jt, collada, ifc, 3ds 파일 등을 웹에서 동작하게 하는 converter, 브라우저에서 3D Rendering을 담당하는 js, 이슈 관리를 위한 was 시스템으로 구성 되어 있다. </div>
			<div>
				<div>F4D Converter</div>
				<div>mago3DJS</div>
				<div>Issue Managerment System</div>
			</div>
			<div class="sub_title">mago3D 활용 분야</div>
			<div>
				<div>3D Content Management System - F4D Converter, mago3DJS, Issue Managerment System Full package 솔루션</div>
				<div>3D Rendering View - 사내 업무 시스템 또는 이슈 관리 시스템이 존재하는 경우 F4D Converter, mago3DJS 를 이용하여 3D Rendering 기능을 제공</div>
			</div>
			
			<div class="sub_title">API Reference Documentation</div>
			<ul class="docs-list">
				<li><a href="/homepage/api.do">mago3D.JS API</a>는 JavaScript에 관한 API를 설명한 문서입니다.</li>
				<li>준비 중 입니다.</li>
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