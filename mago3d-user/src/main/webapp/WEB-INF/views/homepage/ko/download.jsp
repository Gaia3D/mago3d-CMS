<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

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
<link href="https://fonts.googleapis.com/css?family=Noto+Sans"
	rel="stylesheet">
<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
<script type="text/javascript" src="/js/analytics.js"></script>
<script type="text/javascript" src="/js/${lang }/common.js"></script>
<script type="text/javascript" src="/js/${lang }/message.js"></script>
</head>

<body>
	<nav class="nav">
		<div>
			<h1>
				<a href="./index.do">mago3D</a>
			</h1>
			<ul class="menu">
				<li><a href="/homepage/about.do">mago3D</a></li>
				<li><a href="/homepage/demo.do">Demo</a></li>
				<li class="on">Download<span></span></li>
				<li><a href="/homepage/tutorials.do">Tutorials</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on"><a href="#"
					onclick="changeLanguage('ko');">KO</a></li>
				<li id="languageEN"><a href="#" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>

	<section>
		<div class="contents">

			<button type="button" class="down" onclick='alert("준비 중 입니다.")'>
				DOWNLOAD Mago3D 1.0.0 <span>123.5 MB</span> <span>2017-07-01</span>
			</button>

			<h4>추가된 기능</h4>
			<ul>
				<li>다양한 유형의 이슈를 등록할 수 있고, 이슈 목록에서 누가,언제,어디서 이슈를 등록했는지 확인 할 수
					있습니다.</li>
				<li>엑셀 형식으로 정의된 파일을 사용하여 더 많은 데이터를 쉽고 빠르게 올릴 수 있는 일괄등록기능이
					생겼습니다.</li>
				<li>Object 정보 표시 기능이 생겼습니다.</li>
				<li>다양한 API를 간편하게 사용할 수 있도록 API목록 기능을 지원하고 있습니다.</li>
			</ul>

			<h4>Quick Start Guide</h4>
			<ol>
				<li>mago3d를 설치합니다.</li>
				<li>설치한 다음에 was(tomcat), web server(nginx, apache),
					DataBase(PostgreSQL + PostGIS)를 설치합니다.</li>
				<li>was와 web server를 사용하여 mago3d를 실행시켜 줍니다.</li>
				<li>mago3d 관리자 홈페이지에서 사용하고자 하는 데이터를 등록 혹은 일괄등록을 사용하여 등록하고 필요한
					자료도 등록하여 줍니다.</li>

			</ol>

			<h4>Documentation</h4>
			<table>
				<tr>
					<th>JS Document</th>
					<th>Convert Document</th>
					<th>Biz Document</th>
				</tr>
				<tr>
					<td><a href="#" onclick='alert("준비 중 입니다.")'>Mago3Djs-1.0.0
							js Document</a></td>
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
					<td><a href="#" onclick='alert("준비 중 입니다.")'>Mago3Dall.zip</a></td>
					<td>2017-07-01</td>
					<td>
						<ul>
							<li><a href="https://github.com/Gaia3D/mago3djs">mago3djs</a></li>
							<li><a href="#" onclick='alert("준비 중 입니다.")'>mago3dconver</a></li>
							<li><a href="#" onclick='alert("준비 중 입니다.")'>mago3dbiz</a></li>
						</ul>
					</td>
				</tr>
			</table>

		</div>
	</section>

	<footer>
		<div>
			<h2>
				Contact <span></span>
			</h2>
			<p>Mago3d에 관심이 있는 고객님께서는 아래의 담당자 email, phone 또는 방문을 부탁 드립니다.</p>
			<ul class="contact">
				<li class="company">www.gaia3d.com</li>
				<li class="address">080 2 3397 3475</li>
				<li class="mail">mago3d@gaia3d.com</li>
			</ul>
			<p class="copyright">&copy; 2017. Mago3D all rights reserved.</p>
		</div>
	</footer>
</body>


</html>
