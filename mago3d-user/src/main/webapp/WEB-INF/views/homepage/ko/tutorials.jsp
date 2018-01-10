<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=1250">
<title>Install Guide | mago3D User</title>
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
						<li><a href="/homepage/installguide.do" style="color: white">Tutorials</a></li>
					</ul>
				</li>
				<li><a href="/homepage/faq.do">FAQ</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN"><a href="/homepage/tutorials.do" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="contents">
			<div class="guide">
				<aside>
					<ul>
						<li><a class="on" href="#">Tutorials</a>
						<li><a href="/homepage/setup.do">Setup</a>
						<li><a href="/homepage/gettingstarted.do">Getting Started</a>
					</ul>
				</aside>
				<div class="contents">
					<h3>Tutorials</h3>
					<div class="sub_contents">
						<div class="title">Set Up</div>
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
					<div class="sub_contents">
						<div class="title">Getting Started</div>
						<div class="list">
							<ul>
								<li><a href="#CommunityEdtion">Community Edtion</a>
									<ul class="sub_list">
										<li><a href="#DataConverter">Data 변환</a></li>
										<li><a href="#SettingFiles">설정 파일 수정</a></li>
										<li><a href="#Start">Start</a></li>
									</ul></li>
							</ul>
							<ul>
								<li><a href="#EnterpriseEdtion">Enterprise Edtion</a>
									<ul class="sub_list">
										<li><a href="#JavaInstall">Dashboard, 정책 설정</a></li>
										<li><a href="#EclipseInstall">Data 관리</a></li>
										<li><a href="#GradleInstall">Issue 관리</a></li>
										<li><a href="#PostgreSQLInstall">Role Based Access Control 설정</a></li>
									</ul></li>
							</ul>
						</div>
						
					
<!-- 					<div class="col"> -->
<!-- 						<div class="tutorials"> -->
<!-- 							<a href="/home/"> -->
<!-- 								<div class="title">Community Edition</div> -->
<!-- 								<ul> -->
<!-- 									<li>무료로 제공되며 업무 시스템(이슈관리, 시설물등)이 존재하는 경우 3D Rendering 솔루션으로 사용하는 경우 이상적입니다.</li> -->
<!-- 									<li>F4D Converter + mago3DJs</li> -->
<!-- 								</ul> -->
<!-- 								<span>mago3D Community Edition(F4D Converter + mago3DJS)을 download 후</span> -->
<!-- 								<span>고객이 소유한 3D Data(IFC, 3DS, Collada 등)를 F4D Converter 를 이용하여</span> -->
<!-- 								<span>Render용 F4D Data로 변환 후, mago3DJS(JavaScript) 를 연동하여</span> -->
<!-- 								<span>브라우저에서 확인한다.</span> -->
<!-- 							</a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="col"> -->
<!-- 						<div class="tutorials"> -->
<!-- 							<a href="#"> -->
<!-- 								<div class="title">Enterprise Edition</div> -->
<!-- 								<ul> -->
<!-- 									<li>대용량 3D 데이터를 처리하기 위한 플랫폼으로 데이터 관리, 이슈 관리 기능을 제공 합니다.</li> -->
<!-- 									<li>F4D Converter + mago3DJS + Content Management System</li> -->
<!-- 								</ul> -->
<!-- 								<span>mago3D Enterprise Edition(F4D Converter + mago3DJS + CMS)을</span> -->
<!-- 								<span>download 후 이용하여 Data를 등록, Issue를 관리하는 방법을 확인합니다.</span> -->
<!-- 							</a> -->
<!-- 						</div> -->
<!-- 					</div> -->
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
