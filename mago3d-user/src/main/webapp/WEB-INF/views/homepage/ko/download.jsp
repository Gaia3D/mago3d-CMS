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
    <!--[if lt IE 8]>
    	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css"/>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<nav class="nav">
		<div>
			<h1><a href="./index.do">mago3D</a></h1>
			<ul class="menu">
				<li><a href="/homepage/about.do">mago3D</a></li>
				<li><a href="/homepage/demo.do">Demo</a></li>
				<li class="on">Download<span></span></li>
				<li><a href="/homepage/tutorials.do">Tutorials</a></li>
			</ul>
			<ul class="language">
				<li class="on"><a href="#" onclick ="changeLanguage('ko');">KO</a></li>
				<li><a href="#" onclick ="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	
	<section>
		<div class="contents">

			<button type="button" class="down">
				DOWNLOAD Mago3D 1.0.0
				<span>123.5 MB</span>
				<span>2017-07-01</span>
			</button>

			<h4>추가된 기능</h4>
			<ul>
				<li>다양한 유형의 이슈를 등록할 수 있고, 이슈 목록에서 누가,언제,어디서 이슈를 등록했는지 알 수 있습니다.</li>
				<li>엑셀 형식으로 정의된 파일을 사용하여 더 많은 데이터를 쉽고 빠르게 올릴 수 있는 일괄등록기능이 생겼습니다.</li>
				<li>색깔 및 highlighting 이 추가 되었고 속도는 20배 이상 빨리 하게 되었습니다. 정말 초초초 울트라 스피드 입니다.</li>
				<li>색깔 및 highlighting 이 추가 되었고 속도는 20배 이상 빨리 하게 되었습니다. 정말 초초초 울트라 스피드 입니다.</li>
			</ul>

			<h4>Quick Start Guide</h4>
			<ol>
				<li>mago3d를 설치합니다.</li>
				<li>mago3d를 설치하고 was(tomcat), webserver(nginx, apache)를 설치합니다.</li>
				<li>확인한다</li>
			</ol>

			<h4>Documentation</h4>
			<table>
				<tr>
					<th>JS Document</th>
					<th>Convert Document</th>
					<th>Biz Document</th>
				</tr>
				<tr>
					<td><a href="./documention/index.html">Mago3Djs-1.0.0 js Document</a></td>
					<td></td>
					<td></td>
				</tr>
			</table>

			<h4>소스링크</h4>
			<table>
				<tr>
					<th>버전</th>
					<th>다운로드</th>
					<th>날짜</th>
					<th>GitHub</th>
				</tr>
				<tr>
					<td>1.0.0</td>
					<td><a href="#">Mago3Dall.zip</a></td>
					<td>2017-07-01</td>
					<td>
						<ul>
							<li><a href="https://github.com/Gaia3D/mago3djs">mago3djs</a></li>
							<li>mago3dconver</li>
							<li>mago3dbiz</li>
						</ul>
					</td>
				</tr>
			</table>

		</div>
	</section>

	<footer>
		<div>
			<h2>
				Contact
				<span></span>
			</h2>
			<p>
				Mago3d에 관심이 있는 고객님께서는 아래의 담당자 email, phone 또는 방문을 부탁 드립니다.
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
</body>


</html>
