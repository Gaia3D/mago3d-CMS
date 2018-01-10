<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>download | mago3D User</title>
	<!--[if lt IE 9]>
    	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<script type="text/javascript" src="/js/${lang }/common.js"></script>
	<script type="text/javascript" src="/js/${lang }/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>

	<header class='down'>
	</header>
	
	<nav class="nav">
		<div>
			<h1>
				<a href="/homepage/index.do">mago3D</a>
			</h1>
			<ul class="menu">
				<li class="mm" onclick='selectMenu();'>mago3D<span></span>
					<ul>
						<li><a href="/homepage/about.do" style="color: white">About</a></li>
						<li><a href="/homepage/news.do" style="color: white" onclick="alert('준비 중 입니다.'); return false">News</a></li>
					</ul>
				</li>
				<li class="mm" onclick='selectMenu();'>Demo<span></span>
					<ul>
						<li><a href="/homepage/demo.do" style="color: white">Cesium</a></li>
						<li><a href="/homepage/demo.do?viewLibrary=worldwind"
							style="color: white">World Wind</a></li>
					</ul>
				</li>
				<li class="on">Download<span></span></li>
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
				<li id="languageEN"><a href="/homepage/download.do" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>

	<section>
		<h2>Download</h2>
		
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
				<li>Download버튼을 클릭하여 mago3D소스를 eclipse에서 받아 줍니다.</li>
				<li>다운받은 mago3D를 Existing Gradle Project로 import합니다.</li>
				<li>설치한 다음에 was(tomcat), web server(nginx, apache),
					DataBase(PostgreSQL + PostGIS)를 설치합니다.</li>
				<li>was와 web server를 사용하여 mago3D를 실행시켜 줍니다.</li>
				<li>mago3D 관리자 홈페이지에서 사용하고자 하는 데이터를 등록 혹은 일괄등록을 사용하여 등록하고 필요한
					자료도 등록하여 줍니다.</li>

			</ol>
			<h4>Gaia3D's mago3D Software License:</h4>
			<b>1. F4D Converter: Dual License – Please see below for more details.</b><br><br>
			<p><i>mago3D F4D Converter Commercial License for ISVs and VARs</i><br>Gaia3D provides its mago3D F4D Converter under a dual license model 
			designed to meet the development and distribution needs of both commercial distributors (such as ISVs and VARs) and open source projects.<br>
			<br>
			<i>For ISVs, VARs and Other Distributors of Commercial Applications:</i><br>
			ISVs (Independent Software Vendors), VARs (Value Added Resellers) and other distributors that 
			combine and distribute commercially licensed software with mago3D F4D Converter software and do not wish to distribute the source code 
			for the commercially licensed software under version 3 of the GNU AFFERO GENERAL PUBLIC LICENSE (the "AGPL" https://www.gnu.org/licenses/agpl-3.0.en.html )
			 must enter into a commercial license agreement with Gaia3D.<br><br>
			<i>For Open Source Projects and Other Developers of Open Source Applications:</i><br>
			 For developers of Free Open Source Software ("FOSS") applications under the GPL or AGPL that want to combine and distribute those FOSS 
			 applications with mago3D F4D Converter software, Gaia3D’s open source software licensed under the AGPL is the best option.
			</p>
			<b>2. mago3D.js: Apache 2.0 License</b><br>
			<h4>mago3D.js</h4>
			<table>
				<tr>
					<th>버전</th>
					<th>다운로드</th>
					<th>날짜</th>
					<th>설명</th>
				</tr>
				<tr>
					<td>1.0.0</td>
					<td>
					<ul>
						<li>GitHub : <a href="https://github.com/Gaia3D/mago3Djs" target="_blank">mago3D.js</a></li>
					</ul>
					</td>
					<td>2017-07-01</td>
					<td><a href="https://github.com/Gaia3D/mago3djs/blob/develop/README.md" target="_blank">ReadMe</a>
					</td>
					
				</tr>
			</table>
			
			<h4>F4D Converter</h4>
			<table>
				<tr>
					<th>버전</th>
					<th>다운로드</th>
					<th>날짜</th>
					<th>설명</th>
				</tr>
				<tr>
					<td>0.0.1</td>
					<td>
					<ul>
						<li>GitHub : <a href="https://github.com/Gaia3D/F4DConverter" target="_blank">F4D Converter</a></li>
						<li>Installer : <a href="/data/download/SetupF4DConverter.msi" target="_blank">F4D Converter 64bit (this installation requires Windows 7 or later)</a></li>
					</ul>
					</td>
					<td>2017-08-17</td>
					<td><a href="https://github.com/Gaia3D/F4DConverter/blob/master/README.md" target="_blank">ReadMe</a>
					</td>
				</tr>
			</table>
			
			<h4>Documentation</h4>
			<table>
				<tr>
					<th>버전</th>
					<th>다운로드</th>
					<th>날짜</th>
				</tr>
				<tr>
					<td>0.0.1</td>
					<td>
						<ul>
							<li>tutorials : <a href="/data/download/tutorials.pdf" download>tutorials</a></li>
							<li>API : <a href="/homepage/api.do" target="_blank">mago3D.js API</a></li>
							<li>Spec : <a href="/homepage/spec.do">F4D Converter Spec</a></li>
						</ul>
					</td>
					<td>2017-10-30</td>
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
