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
<link rel="stylesheet" href="/externlib/${lang}/highlight/styles/monokai.css" />
<script type="text/javascript" src="/externlib/${lang}/highlight/highlight.js"></script>
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
				<li id="languageEN"><a href="/homepage/gettingstarted.do" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="contents">
			<div class="guide">
				<aside>
					<ul>
						<li><a href="/homepage/tutorials.do">Tutorials</a>
						<li><a href="/homepage/setup.do">Setup</a>
						<li><a class="on" href="/homepage/gettingstarted.do">Getting Started</a>
					</ul>
				</aside>
				<div class="contents">
					<h3>Getting Started</h3>
					<div class="sub_contents">
						<div class="title">Contant</div>
						<div class="list">
							<ul>
								<li><a href="#CommunityEdtion">Community Edtion</a>
									<ul class="sub_list">
										<li><a href="#DataConverter">Data 변환</a></li>
										<li><a href="#SettingFiles">설정 파일 수정</a></li>
										<li><a href="#Start">Start.html</a></li>
										<li><a href="#JavaScript">mago3D 연동 JavaScript 작성</a></li>
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
					</div>
					<div class="sub_contents">
						<div id="CommunityEdtion"></div>
						<h3 style="margin-top: 80px;">Community Edtion</h3>
						<div id="DataConverter"></div>
						<div class="title">Data 변환</div>
						<p>관리자 권한으로 Command Line Prompt를 실행한 다음 F4D Converter를 설치한 디렉토리로 이동합니다.</p>
						<p>변환한 데이터를 저장할 폴더(outputFolder)를 생성합니다.</p>
						<div class="block">C:\data</div>
						<p>InputFolder에 변환할 데이터를 놓고, 다음을 실행합니다.</p>
						<div class="prompt">
							<div class="admin">관리자: 명령 프롬프트</div>
							<div class="order">C:\F4DConverter>F4DConverter.exe -inputFolder D:\demo_data -outputFolder c:\data -log D:\demo_data/logtTest.txt -indexing y</div>
							<b> ※ argument 관련 설명은 <a href="https://github.com/Gaia3D/F4DConverter">https://github.com/Gaia3D/F4DConverter</a>참조
							</b>
							<ul style="margin-left: 19px; margin-bottom: 3px;">
								<li>inputFolder [rawDataFolder] : an absolute path of the folder where raw data files to be converted are.</li>
								<li>outputFolder [F4DFolder] : an absolute path of the folder where conversion results(F4D datasets) are created</li>
								<li>log [logFileFullPath] : an absolute path of a log file which is created after finishing conversion processes</li>
								<li>indexing [one of Y, y, N, n] : wheter objectIndexFile.ihe should be created or not. "NOT created" is default</li>
							</ul>
							<b>C:\data 폴더에 F4D_xxxx 폴더들과, objectIndexFile.ihe 파일 생성을 확인 파일이 생성되지 않은 경우 로그파일(logTest.txt)를 확인</b>
						</div>
					</div>
					<div class="sub_contents">
						<div id="SettingFiles"></div>
						<div class="title">설정 파일 수정</div>
						<p>Community Edtion버전에서는 두개의 설정 파일을 가지고 있습니다.</p>
						<p>mago3DJS Rendering 관련 설정을 담당하는 policy.json 파일과 Data의 Location 정보를 담당하는 data.json 파일이 있습니다.</p>
						<ul>
							<li>Policy.json
								<ul>
									<li>Init Camera Latitude, Longitude, CallBack Function, Geo Server 설정 등</li>
								</ul>
							</li>
							<li>Data.json
								<ul>
									<li>Data Key, Name, Latitude, Longitude, Altitude, Heading, Pitch, Roll 설정 등</li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="sub_contents">
						<div id="Start"></div>
						<div class="title">Start.html</div>
						<ul>
							<li>Ajax 통신을 위해 jQuery를 추가 합니다.</li>
							<li>Customizer 된 Cesium을 추가 합니다.</li>
							<li>mago3DJS 사용을 위해 mago3d.js를 추가 합니다. mago3D Project를 gulp를 이용해서 build를 하면 build 디렉토리에 생성됩니다. 생성된 build파일을 사용합니다.</li>
						</ul>
						<pre>
<code class="html">&lt;link rel="stylesheet" href="/src/engine/cesium/Widgets/widgets.css"/&gt;
&lt;script type="text/javascript" src="/thirdparty/jquery/jquery.js"&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="/src/engine/cesium/Cesium.js"&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="/tutorials/mago3d.js"&gt;&lt;/script&gt;
</code>
						</pre>
						<p>Cesium map을 render할 div 영역을 설정합니다.</p>
						<pre>
<code class="html">&lt;div id="magoContainer" class="mapWrap"&gt;&lt;/div&gt;
</code>
						</pre>
						<br>
						<div class="sub_contents">
							<div class="title">mago3D 연동 JavaScript 작성</div>
							<pre>
<code class="javascript">var imagePath = "images/ko";
magoStart(null, "magoContainer", null, null); // cesium map을 render할 div

// mago3d 시작, 정책 데이터 파일을 로딩
function magoStart(viewer, renderDivId, imagePath) {
	$.ajax({
		url: "/tutorials/policy-tutorials.json", //policy json 설정
		type: "GET",
		dataType: "json",
		success: function(serverPolicy) {
			loadData(viewer, renderDivId, serverPolicy);
		},
		error: function(e) {
			alert(e.responseText);
		}
	});
}

function loadData(viewer, renderDivId, serverPolicy) {
	$.ajax({
		url: "/tutorials/data-tutorials.json", //data json 설정
		type: "GET",
		dataType: "json",
		success: function(serverData) {
			managerFactory = new ManagerFactory(viewer, renderDivId, serverPolicy,
			 serverData, imagePath); // mago3D Start
		},
		error: function(e) {
			alert(e.responseText);
		}
	})
}
</code>
						</pre>
						</div>
						<div class="sub_contents">
							<div class="title">Node Server 실행</div>
							<div class="prompt">
								<div class="admin">명령 프롬프트 - node server.js</div>
								<div class="order">C:\git\repository\mago3djs><span class="order-color"> node server.js <br>Mago3D development server running
								locally. Connect to http://localhost:80</span> </div>
							</div>
						</div>
						<div class="sub_contents">
							<div class="title">API 연동</div>
							<p>API 연동 </p>
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

<script>
	hljs.initHighlightingOnLoad();
</script>

</html>
