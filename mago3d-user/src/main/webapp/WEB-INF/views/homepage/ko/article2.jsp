<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>mago3D 웹페이지 오픈 안내 | mago3D User</title>
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
				<div class="news-contents">
					<h3>mago3D 웹페이지 오픈 안내</h3>
					<img src="/images/${lang}/homepage/logo_mago3d.png" style="margin-left: 80px;">
					<p>안녕하세요?</p><br>
					<p>가이아쓰리디의 차세대 3차원 플랫폼인 mago3D를 위한 별도 웹페이지를 오픈하였습니다. 웹페이지 주소는 http://www.mago3d.com/ 이며, mago3D에 대한 개략적인 정보와 라이브 데모 페이지를 제공하고 있습니다. 데모 페이지에서는 누구나 3차원 객체 위에 이슈 사항을 등록할 수 있고, 3차원 객체를 클릭하여 속성정보를 확인할 수 있습니다. 앞으로 다양한 3차원 정보들이 수집되는대로 지속적으로 데모의 내용을 확장해 나갈 예정입니다. 당장 7월 중순 이전에 NASA World Wind에 기초한 데모 페이지와 영문 페이지가 론칭될 것입니다.</p>
					<br>
					<p>mago3D는 HTML5 기반으로 별도의 플러그인이나 엑티브엑스 설치 없이 BIM, AEC 데이터를 GIS와 통합하여 웹 브라우저 상에서 바로 가시화하고 정보를 공유할 수 있습니다. 여러분의 많은 관심과 활용 부탁 드립니다.</p>
					<br>
					<p>감사합니다.</p>
					<p>가이아쓰리디(주)</p>
					<div class="nextpre">
						<ul>
							<li class="next">
								<a href="/homepage/news1.do">
									<img alt="next" src="/images/${lang}/homepage/next.png">
									쌍용자동차 사보에 신상희 대표의 인터뷰가 실렸습니다.
								</a>
							</li>
							<li class="pre">
								<a href="/homepage/news3.do">
									mago3D, FOSS4G Europe 2017의 발표 주제로 선정
									<img alt="pre" src="/images/${lang}/homepage/pre.png">
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="secondary-content" style="margin-top: -663px">
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