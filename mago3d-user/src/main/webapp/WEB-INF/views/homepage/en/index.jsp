<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <title>Mago3D</title>
    <!--[if lt IE 9]>
    	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.slidertron-1.1.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css"  type="text/css" />
	<script type="text/javascript" src="/js/analytics.js"></script>
	<script type="text/javascript" src="/js/${lang }/common.js"></script>
	<script type="text/javascript" src="/js/${lang }/message.js"></script>
</head>

<body>
	<nav class="nav">
		<div>
			<h1>mago3D</h1>
			<ul class="menu">
				<li><a href="/homepage/about.do">mago3D</a></li>
				<li><a href="/homepage/demo.do">Demo</a></li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li><a href="/homepage/tutorials.do">Tutorials</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO"><a href="" onclick ="changeLanguage('ko');">KO</a></li>
				<li id="languageEN" class="on"><a href="" onclick ="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>

	<section>
		<div class="contents">

			<div id="slider">
				<div class="viewer">
					<div class="reel">
						<div class="slide">
							<img src="/images/slider01.png" alt="" />
						</div>
						<div class="slide">
							<img src="/images/slider02.png" alt="" />
						</div>
						<div class="slide">
							<img src="/images/slider03.png" alt="" />
						</div>
						<div class="slide">
							<img src="/images/slider04.png" alt="" />
						</div>
						<div class="slide">
							<img src="/images/slider05.png" alt="" />
						</div>
					</div>
				</div>
			</div>

			<script>
				var $slider = $('#slider');
				if ($slider.length > 0) {
					$slider.slidertron({
						mode : 'fade',
						seamlessWrap : false,
						viewerSelector : '.viewer',
						reelSelector : '.viewer .reel',
						slidesSelector : '.viewer .reel .slide',
						advanceDelay : 3000,
						speed : 600,
						fadeInSpeed : 1500,
						autoFit : true,
						autoFitAspectRatio : (1200 / 832)
					});
				}
			</script>
			
		</div>
	</section>

	<footer>
		<div>
			<h2>
				Contact
				<span></span>
			</h2>
			<p>
				If you are interested in Mago3D, please contact us by email or phone or visit us directly.
			</p>
			<ul class="contact">
				<li class="company">www.gaia3d.com</li>
				<li class="address">080 2 3397 3475</li>
				<li class="mail">mago3d@gaia3d.com</li>
			</ul>
			<p class="copyright">
				&copy; 2017. Mago3D all rights reserved.
			</p>
		</div>
	</footer>
	<!-- //FOOTER -->
</body>
</html>
