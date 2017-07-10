<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<title>download | mago3D User</title>
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

	<header class='down'>
		<div>
			<p>Architecture, Engineering, Construction</p>
			<p>대용량 3차원GIS를 쉽고 빠르게 웹에서 구현합니다</p>
		</div>
	</header>
	
	<nav class="nav">
		<div>
			<h1>
				<a href="/homepage/index.do">mago3D</a>
			</h1>
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
				<li class="on">Download<span></span></li>
				<li><a href="/homepage/tutorials.do">Tutorials</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN"><a href="#" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>

	<section>
		<div class="contents">
			<button type="button" class="down" onclick="location.href='https://github.com/Gaia3D/mago3d'">
				DOWNLOAD mago3D 1.0.0 <span>2017-07-01</span>
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
				<li>mago3D를 설치합니다.</li>
				<li>설치한 다음에 was(tomcat), web server(nginx, apache),
					DataBase(PostgreSQL + PostGIS)를 설치합니다.</li>
				<li>was와 web server를 사용하여 mago3D를 실행시켜 줍니다.</li>
				<li>mago3D 관리자 홈페이지에서 사용하고자 하는 데이터를 등록 혹은 일괄등록을 사용하여 등록하고 필요한
					자료도 등록하여 줍니다.</li>

			</ol>
			<h4>Gaia3D's mago3D Software License:</h4>
			<b>1. F4G Converter: Dual License – Please see below for more details.</b><br><br>
			<p><i>mago3D F4D Converter Commercial License for OEMs, ISVs and VARs</i><br>Gaia3D provides its mago3D F4D Converter under a dual license model 
			designed to meet the development and distribution needs of both commercial distributors (such as OEMs, ISVs and VARs) and open source projects.<br>
			<br>
			<i>For OEMs, ISVs, VARs and Other Distributors of Commercial Applications:</i><br>
			OEMs (Original Equipment Manufacturers), ISVs (Independent Software Vendors), VARs (Value Added Resellers) and other distributors that 
			combine and distribute commercially licensed software with mago3D F4D Converter software and do not wish to distribute the source code 
			for the commercially licensed software under version 3 of the GNU AFFERO GENERAL PUBLIC LICENSE (the "AGPL" https://www.gnu.org/licenses/agpl-3.0.en.html )
			 must enter into a commercial license agreement with Gaia3D.<br><br>
			<i>For Open Source Projects and Other Developers of Open Source Applications:</i><br>
			 For developers of Free Open Source Software ("FOSS") applications under the GPL or AGPL that want to combine and distribute those FOSS 
			 applications with mago3D F4D Converter software, Gaia3D’s open source software licensed under the AGPL is the best option.
			</p>
			<b>2. mago3D.js: Apache License</b><br>
			<h4>Documentation</h4>
			<table>
				<tr>
					<th>JS Document</th>
					<th>Convert Document</th>
					<th>Biz Document</th>
				</tr>
				<tr>
					<td><a href="#" onclick='alert("준비 중 입니다."); return false;'>mago3Djs-1.0.0
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
					<td><a href="#" onclick='alert("준비 중 입니다.")'>mago3Dall.zip</a></td>
					<td>2017-07-01</td>
					<td>
						<ul>
							<li><a href="https://github.com/Gaia3D/mago3Djs">mago3Djs</a></li>
							<li><a href="#" onclick='alert("준비 중 입니다."); return false;'>mago3Dconver</a></li>
							<li><a href="#" onclick='alert("준비 중 입니다."); return false;'>mago3Dbiz</a></li>
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
