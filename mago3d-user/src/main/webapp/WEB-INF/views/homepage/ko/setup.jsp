<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=1250">
<title>Community Edtion | mago3D User</title>
<!--[if lt IE 9]>
	   	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
<link rel="stylesheet" href="/css/${lang}/font/font.css" />
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<%-- <script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script> --%>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<header class='about'> </header>

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
						<li><a href="/homepage/demo.do?viewLibrary=worldwind" style="color: white">World Wind</a></li>
					</ul>
				</li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li class="mm on" onclick='selectMenu();'>Documentation<span></span>
					<ul>
						<li><a href="/homepage/api.do" style="color: white" target="_blank">API</a></li>
						<li><a href="/homepage/spec.do" style="color: white">F4D Spec</a></li>
						<li><a href="/homepage/installguide.do" style="color: white">Install Guide</a></li>
					</ul>
				</li>
				<li><a href="/homepage/faq.do">FAQ</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN"><a href="/homepage/setup.do" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="contents">
			<div class="guide">
				<aside>
					<ul>
						<li><a href="/homepage/tutorials.do">Tutorials</a></li>
						<li><a class="on" href="#">Setup</a></li>
						<li><a href="/homepage/gettingstarted.do">Getting Started</a></li>
					</ul>
				</aside>
				<div class="contents">
					<h3>Set Up</h3>
					<div class="sub_contents">
						<div class="title">Contant</div>
						<div class="list">
							<ul>
								<li><a href="#CommunityEdtion">Community Edtion</a>
									<ul class="sub_list">
										<li><a href="#SourceDownload">Source Download</a></li>
										<li><a href="#NodeInstall">Node Install</a></li>
										<li><a href="#F4DConverter">F4D Converter Install</a></li>
									</ul></li>
							</ul>
							<ul>
								<li><a href="#EnterpriseEdtion">Enterprise Edtion</a>
									<ul class="sub_list">
										<li><a href="#JavaInstall">Java Install</a></li>
										<li><a href="#EclipseInstall">Eclipse Install</a></li>
										<li><a href="#GradleInstall">Gradle Install</a></li>
										<li><a href="#PostgreSQLInstall">PostgreSQL Install</a></li>
										<li><a href="#PostGISInstall">PostGIS Install</a></li>
										<li><a href="#LombokInstall">Lombok Install</a></li>
										<li><a href="#eSourceDownload">Source Download</a></li>
									</ul></li>
							</ul>
						</div>
					</div>
					<div id="CommunityEdtion">
						<h3 style="margin-top: 80px;">Community Edtion</h3>
						<div class="sub_contents">
							<div id="SourceDownload"></div>
							<div class="title ">Source Download</div>
							<p>아직 mago3DJS를 설치하지 않았다면 아래 버튼을 클릭하여 C:\ 디렉토리에 저장합니다.</p>
							<button type="button" class="down" onclick="location.href='https://github.com/Gaia3D/mago3djs/archive/develop.zip'">
								DOWNLOAD mago3DJS 1.0.0 <span>2017-07-01</span>
							</button>
							<p>
								만약 압축파일이 이름이 <b>mago3djs-develop</b>이면 <b>mago3djs</b>로 변경한 다음 아래 경로에 압축을 해제 합니다.
							</p>
							<div class="block">C:\git\repository\mago3djs</div>
						</div>
						<div class="sub_contents">
							<div id="NodeInstall"></div>
							<div class="title">Node Install</div>
							<p>
								<a href="https://nodejs.org/ko/download/" style="display: inline;">node.js</a>홈페이지로 가서 설치하려는 윈도우 버전에 맞게 설치 파일을 받아 C:\nodejs 디렉토리에 설치합니다.
							</p>
							<div class="images">
								<img src="/images/${lang}/homepage/installguide/node.png" style="width: 410px;"> <img src="/images/${lang}/homepage/installguide/node2.png"> <span class="dis">node.js 윈도우 버전 선택</span> <span class="dis" style="margin-left: 270px;">node.js 설치 시작</span>
							</div>
							<div class="list">
								<ul style="margin-bottom: 14px;">
									<li>node.js 설치가 끝나면 C:\git\repository\mago3djs 디렉토리로 이동합니다.</li>
									<li>mago3DJS에 필요한 node_modules를 Node Package Manager 사용하여 설치합니다.</li>
									<li>gulp는 터미널에서 모듈의 멍령어를 사용하기 위해 -g(global) 옵션을 추가하여 설치합니다.</li>
								</ul>
							</div>
							<div class="block">C:\git\repository\mago3djs> npm install</div>
							<div class="block">C:\git\repository\mago3djs> npm install -g gulp</div>
						</div>
						<div class="sub_contents">
							<div id="F4DConverter"></div>
							<div class="title">F4D Converter Install</div>
							<p>F4D Converter 다운 받아줍니다.</p>
							<div class="block">
								<a href="/data/download/SetupF4DConverter.msi">F4D Converter 64bit (this installation requires Windows 7 or later)</a>
							</div>
							<div class="gettingstarted">
								<a href="#">Getting Started!!</a>
							</div>

						</div>
					</div>
					<div id="EnterpriseEdtion">
						<h3 style="margin-top: 80px;">Enterprise Edtion</h3>
						<div class="sub_contents">
							<div id="JavaInstall"></div>
							<div class="title">Java Install</div>
							<p>java jdk-8u144-windows-x64.exe를 설치합니다.</p>
							<div class="block">
								<a href="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html ">http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html </a>
							</div>
						</div>
						<div class="sub_contents">
							<div id="EclipseInstall"></div>
							<div class="title">Eclipse Install</div>
							<p>Eclipse neon버전 이상을 설치합니다.</p>
							<div class="block">
								<a href="https://www.eclipse.org/downloads/eclipse-packages/" style="display: inline">https://www.eclipse.org/downloads/eclipse-packages/</a>
							</div>
						</div>
						<div class="sub_contents">
							<div id="GradleInstall"></div>
							<div class="title">Gradle Install</div>
							<p>Gradle 4.1버전을 C:\gradle 경로에 설치하고 시스템 변수를 추가합니다. -path -> C:\gradle\gradle-4.1</p>
							<div class="block">
								<a href="https://gradle.org/releases/">https://gradle.org/releases/</a>
							</div>
						</div>
						<div class="sub_contents">
							<div id="PostgreSQLInstall"></div>
							<div class="title">PostgreSQL Install</div>
						</div>
						<div class="sub_contents">
							<div id="PostGISInstall"></div>
							<div class="title">PostGIS Install</div>
						</div>
						<div class="sub_contents">
							<div id="LombokInstall"></div>
							<div class="title">Lombok Install</div>
						</div>
						<div class="sub_contents">
							<div id="eSourceDownload"></div>
							<div class="title">Source Download</div>
						</div>
						<div class="gettingstarted">
							<a href="#">Getting Started!!</a>
						</div>
					</div>

				</div>
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


</html>
