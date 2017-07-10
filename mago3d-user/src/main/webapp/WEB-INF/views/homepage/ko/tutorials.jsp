<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <title>tutorials | mago3D User</title>
    <!--[if lt IE 9]>
    	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css"></link>
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<script type="text/javascript" src="/js/${lang }/common.js"></script>
	<script type="text/javascript" src="/js/${lang }/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<header class='tuto'>
		<div>
			<p>Architecture, Engineering, Construction</p>
			<p>대용량 3차원GIS를 쉽고 빠르게 웹에서 구현합니다</p>
		</div>
	</header>
	
	<nav class="nav">
		<div>
			<h1><a href="/homepage/index.do">mago3D</a></h1>
			<ul class="menu">
				<li><a href="/homepage/about.do">mago3D</a></li>
				<li>
					Demo
					<ul>
						<li>
							<a href="/homepage/demo.do">cesium</a> | 
							<a href="/homepage/demo.do?viewLibrary=worldwind">worldwind</a>
						</li>
					</ul>
				</li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li class="on">Tutorials<span></span></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN"><a href="" onclick ="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	
	<section>
		<h2>Tutorials<span></span></h2>
		<div class="contents">
			<ul class="subMenu">				
				<li>삼각형 꼭지점 순서 보정</li>
				<li>Object 정보 표시 API</li>
				<li>Issue 목록 API</li>
				<li>장소 이동 API</li>
				<li>My Issue API</li>
			</ul>
			<div class="subContents">
				<dl>
					<dt id="Started">삼각형 꼭지점 순서 보정</dt>
					<dd class="img">
						<img src="/images/${lang}/homepage/face_culling.png">
					</dd>
					<dd>
						<b>face culling -WebGL이 지원하는 성능 향상 기법</b>
						<ul>
							<li> WebGL이 rendering을 수행할 때 기본적으로 face culling을 수행하여 성능을 향상시킨다.</li>
							<li> face culling이란 카메라가 삼각형의 뒷면을 보고 있다면 삼각형을 그리지 않는 기법 </li>
							<li> 삼각형의 앞/뒷면을 결정하는 것은 삼각형의 꼭지점 순서</li>
						</ul>
					</dd>
				</dl>
				<dl>
					<dt>Object 정보 표시 API</dt>
					<dd class="img">
						<img src="/images/${lang}/homepage/about.png">
					</dd>
					<dd>
						준비 중 입니다.
					</dd>
				</dl>
				<dl>
					<dt>Issue 목록 API</dt>
					<dd class="img">
						<img src="/images/${lang}/homepage/about.png">
					</dd>
					<dd>
						준비 중 입니다.
					</dd>
				</dl>
				<dl>
					<dt>My Issue API</dt>
					<dd class="img">
						<img src="/images/${lang}/homepage/about.png">
					</dd>
					<dd>
						준비 중 입니다.
					</dd>
				</dl>
			</div>
		</div>		
	</section>
	
	<footer>
		<div>
			<h2>
				Contact
				<span></span>
			</h2>
			<p>
				mago3D 에 관심있는 고객들께서는 연락(이메일, 전화) 또는 직접 방문을 부탁드립니다.
			</p>
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