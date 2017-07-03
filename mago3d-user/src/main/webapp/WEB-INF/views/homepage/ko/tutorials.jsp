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
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
 	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet"> 
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css"/>
	<script type="text/javascript" src="/js/analytics.js"></script>
	<script type="text/javascript" src="/js/${lang }/common.js"></script>
	<script type="text/javascript" src="/js/${lang }/message.js"></script>	
</head>

<body>
	<nav class="nav">
		<div>
			<h1><a href="./index.do">mago3D</a></h1>
			<ul class="menu">
				<li><a href="/homepage/about.do">mago3D</a></li>
				<li><a href="/homepage/demo.do">Demo</a></li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li class="on">Tutorials</li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on"><a href="" onclick ="changeLanguage('ko');">KO</a></li>
				<li id="languageEN"><a href="" onclick ="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	
	<section>
		<h2>Tutorials<span></span></h2>
		<div class="contents">
			<ul class="subMenu">				
				<li>Issue 등록 API</a></li>
				<li>Object 정보 표시 API</li>
				<li>Issue 목록 API</li>
				<li>장소 이동 API</li>
				<li>My Issue API</li>
			</ul>
			<div class="subContents">
				<dl>
					<dt id="Started">Issue 등록 API</dt>
					<dd class="img">
						<img src="/images/${lang}/homepage/about.png">
					</dd>
					<dd>
						준비 중 입니다.
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
			<p class="copyright">
				&copy; 2017 Gaia3D, Inc.
			</p>
		</div>
	</footer>
</body>


</html>