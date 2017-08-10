<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>FAQ | mago3D User</title>
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
	<header class='about'>
<!-- 		<div> -->
<!-- 			<p>Architecture, Engineering, Construction</p> -->
<!-- 			<p>대용량 3차원GIS를 쉽고 빠르게 웹에서 구현합니다</p> -->
<!-- 		</div> -->
	</header>

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
				<li><a href="/homepage/docs.do">Documentation</a></li>
				<li class="on">FAQ<span></span></li>
			</ul>
			<ul class="language">
				<li id="languageKO" ><a href="#" onclick="changeLanguage('ko');">KO</a></li>
				<li id="languageEN" class="on">EN</li>
			</ul>
		</div>
	</nav>
	<section>
		<h2 style="margin-bottom: 5px;">FAQ</h2>
		<div class="line"></div>
		<div class="contents">
		<div id="faq_menu" style="margin-bottom: 50px;">
		<ul>
				<li><a href="#mago3D">What is mago3D?</a></li>
				<li><a href="#mago3DJS">What is mago3DJS?</a></li>
				<li><a href="#mago3Dneed">Why do I need mago3D?</a></li>
			</ul>
		</div>
		<div id="faq_main">
			<div class="sub_title"><span id="mago3D">What is mago3D?</span></div>
			<p>
				MAGO3D is a next-generation 3D platform that integrates and visualizes AEC (Architecture, Engineering, Construction) and traditional 3D spatial information (3D GIS).
			</p>
			<div class="sub_title">What is mago3DJS?<span id="mago3DJS"></span></div>
			<p>
				Open-source JavaScript library for 3D multi-block visualization.
			</p>
			<div class="sub_title"><span id="mago3Dneed">Why do I need mago3D?</span></div>
			<p>
				Unlike existing solutions, MAGO3D seamlessly integrates AEC and 3D GIS in a web browser without distinction between indoor and outdoor. As a result, MAGO3D users can quickly view and collaborate on large-capacity building information modeling (BIM), JT (Jupiter Tessellation) and 3D GIS files without installing any additional programs.
			</p>
		</div>
		</div>

	</section>

	<footer style="margin-top: 68px;">
		<div>
			<h2>
				Contact <span></span>
			</h2>
			<p>If you are interested in mago3D, please contact us by email or phone or visit us directly.</p>
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
