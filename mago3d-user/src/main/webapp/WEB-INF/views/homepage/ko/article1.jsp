<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title> 쌍용자동차 사보에 신상희 대표의 인터뷰가 실렸습니다. | mago3D User</title>
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
				<li class="mm on" onclick='selectMenu();'>mago3D<span></span>
					<ul>
						<li><a href="/homepage/about.do" style="color: white">About</a></li>
						<li><a href="/homepage/news.do" style="color: white">News</a></li>
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
				<li onclick='selectMenu();'>Documentation<span></span>
					<ul>
						<li><a href="/homepage/api.do" style="color: white" target="_blank">API</a></li>
						<li><a href="/homepage/spec.do" style="color: white">F4D Spec</a></li>
					</ul>
				</li>
				<li><a href="/homepage/faq.do">FAQ</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN"><a href="#" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="content">
			<div class="news-main">
				<div class="news-contents" style="height: 1558px;">
					<jsp:include page="/homepage/news.do">
						<jsp:param value="쌍용" name="title"/>
					</jsp:include>
					<c:set var="title" value="쌍용자동차 사보에 신상희 대표의 인터뷰가 실렸습니다."></c:set>
					<h3>${title}</h3>
					<p>안녕하세요?</p>
					<br>
					<p>쌍용자동차 사보인 ‘네바퀴로 가는 길’ 6월호에 가이아쓰리디 신상희 대표이사의 인터뷰와 회사 소개가 실렸습니다. 신상희 대표는 인터뷰를 통해 오픈스트리트맵, 오픈소스GIS 및 mago3D에 대한 자신의 생각과 계획을 밝혔습니다. 인터뷰 원본은 가까운 쌍용자동차 대리점이나 인터넷http://www.smotor.com/kr/magazine/201706/ecatalog.html 에서 보실 수 있습니다.</p>
					<br>
					<p>감사합니다.</p>
					<p>가이아쓰리디(주)</p>
					<div><img src="/images/${lang}/homepage/news1.png" style="margin-top: 30px"></div>
					<div><img src="/images/${lang}/homepage/news2.png"></div>
					<div class="nextpre">
						<ul>
							<li class="pre">
								<a href="/homepage/news2.do">
									mago3D 웹페이지 오픈 안내
									<img alt="pre" src="/images/${lang}/homepage/pre.png">
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="secondary-content" style="margin-top: -1532px">
				<div class="con">
					<h3>문의하기</h3>
					<a href="mailto:info@gaia3d.com" style="color: blue;">info@gaia3d.com</a><br>
				</div>
				<div class="">
					<h3>트위터</h3>
					<div class="secondary-tw">RT : <a href="https://twitter.com/endofcap">@endofcap</a> <a href="https://twitter.com/OSGeo"> @OSGeo</a></div>
				</div>
			</div>
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