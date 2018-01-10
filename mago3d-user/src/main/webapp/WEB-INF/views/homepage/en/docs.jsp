<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>Docs | mago3D User</title>
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
				<li><a href="/homepage/faq.do">FAQ</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO"><a href="/homepage/docs.do" onclick="changeLanguage('ko');">KO</a></li>
				<li id="languageEN" class="on">EN</li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="docs-menu">
			<ul>
				<li class="on"><a href="/homepage/docs.do">Docs</a></li>
				<li><a href="/homepage/api.do" target="_blank">mago3D.js</a></li>
				<li><a href="/homepage/spec.do">F4D Converter</a></li>
			</ul>
		</div>
		<div class="docs-main">
			<div class="title">Documentation</div>
			<p>	
				Mago3D is a next-generation 3D platform that integrates and visualizes AEC (Architecture, Engineering, Construction) areas and traditional 3D spatial information (3D GIS).
				Mago3D seamlessly integrates AEC and 3D GIS in a web browser, indistinguishable from existing solutions.
				As a result, mago3D users can quickly view and collaborate on large-scale building information modeling (BIM), JT (Jupiter Tessellation) and 3D GIS files without installing any additional programs.
			</p>
			<div class="sub_title">mago3D architecture</div>
			<div>Jt, collada, ifc, and 3ds files on the web, js for 3D rendering in the browser, and was system for issue management.</div>
			<div>
				<div>F4D Converter</div>
				<div>mago3DJS</div>
				<div>Issue Managerment System</div>
			</div>
			<div class="sub_title">Applications of mago3D</div>
			<div>
				<div>3D Rendering View - Provides 3D rendering function using F4D Converter and mago3DJS when there is in-house business system or issue management system</div>
				<div></div>
			</div>
			
			<div class="sub_title">API Reference Documentation</div>
			<ul class="docs-list">
				<li><a href="/homepage/api.do">mago3D.JS API</a>is a document describing the API for JavaScript.</li>
				<li>Coming soon.</li>
			</ul>
		</div>
	</section>
	<footer style="margin-top: 67px;">
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