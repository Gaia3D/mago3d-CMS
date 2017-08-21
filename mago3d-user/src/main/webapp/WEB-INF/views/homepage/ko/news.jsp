<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>news | mago3D User</title>
	<!--[if lt IE 9]>
	   	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/externlib/${lang}/slick/slick.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/slick/slick.js"></script>
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
				<li class="mm on" onclick='selectMenu();'>mago3D<span></span>
					<ul>
						<li><a href="/homepage/about.do" style="color: white">about</a></li>
						<li><a href="#" style="color: white">News</a></li>
					</ul>
				</li>
				<li class="mm" onclick='selectMenu();'>Demo<span></span>
					<ul>
						<li><a href="/homepage/demo.do" style="color: white">Cesium</a></li>
						<li><a href="/homepage/demo.do?viewLibrary=worldwind"
							style="color: white">World Wind</a></li>
					</ul>
				</li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li class="mm" onclick='selectMenu();'>Documentation<span></span>
					<ul>
						<li><a href="/homepage/api.do" style="color: white" target="_blank">API</a></li>
						<li><a href="/homepage/spec.do" style="color: white">F4D Spec</a></li>
					</ul>
				</li>
				<li> <a href="/homepage/faq.do">FAQ</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN"><a href="#" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="contents">
		<h2>News</h2>
			<div class="slider">
				<div class="fade slick-slider">
					<img src="/images/${lang}/homepage/data.png"/>
					<img src="/images/${lang}/homepage/data.png"/>
					<img src="/images/${lang}/homepage/data.png"/>
				</div>
			</div>
			<div class="new_main">
				dfgdfgdgggggggggg
			</div>
		</div>
	</section>
	<footer>
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
<script>
$('.single-item').slick();
$('.fade').slick({
	  dots: true,
	  infinite: true,
	  speed: 500,
	  fade: true,
	  cssEase: 'linear'
	});
</script>

</html>
