<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>FAQ | mago3D User</title>
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
	<header class='about'>
<!-- 		<div> -->
<!-- 			<p>Architecture, Engineering, Construction</p> -->
<!-- 			<p>대용량 3차원GIS를 쉽고 빠르게 웹에서 구현합니다</p> -->
<!-- 		</div> -->
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
				<li><a href="/homepage/download.do">Download</a></li>
				<li class="mm" onclick='selectMenu();'>Documentation<span></span>
					<ul>
						<li><a href="/homepage/api.do" style="color: white" target="_blank">API</a></li>
						<li><a href="/homepage/spec.do" style="color: white">F4D Spec</a></li>
					</ul>
				</li>
				<li class="on">FAQ<span></span></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN"><a href="#" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<h2 style="margin-bottom: 5px;">FAQ</h2>
		<div class="line"></div>
		<div class="contents">
			<div id="faq_menu" style="margin-bottom: 50px;">
				<ul>
					<li><a href="#mago3D">mago3D란 무엇입니까?</a></li>
					<li><a href="#browser">어떤 브라우저를 지원합니까?</a></li>
					<li><a href="#jtformat">JT포맷을 사용하고 싶습니다. 어떻게 해야 합니까?</a></li>
					<li><a href="#License">mago3DJS, F4D Converter각 라이센스는 어떻게 사용해야 합니까?</a></li>
					<li><a href="#mago3DJSbug">mago3DJS에서 버그를 발견했습니다. 어떻게 해야 합니까?</a></li>
					<li><a href="#mago3Dbug">mago3D 전체에서 버그를 발견하거나 다른 질문이 있는 경우에는 어떻게 해야 합니까?</a></li>
				</ul>
			</div>
			<div id="faq_main">
				<div>
					<div class="sub_title"><span id="mago3D">mago3D란 무엇입니까?</span></div>
					<p>
						MAGO3D는 AEC(Architecture, Engineering, Construction) 영역과 전통적인 3차원 공간정보(3D GIS)를 통합적으로 관리, 가시화해 주는 차세대 3차원 플랫폼입니다. 
					</p>
				</div>
				<div>
					<div class="sub_title"><span id="browser">어떤 브라우저를 지원합니까?</span></div>
					<p>
						이 데모 페이지는 대용량 웹 데이터 처리를 위해 Chrome 브라우저에 최적화 되어 있습니다. 원활한 서비스 이용을 위해 Chrome 브라우저를 이용 하시기 바랍니다.
					</p>
				</div>	
				<div>
					<div class="sub_title"><span id="jtformat">JT포맷을 사용하고 싶습니다. 어떻게 해야 합니까?</span></div>
					<p>
						JT포맷은 회사에 따로 연락해주셔야 합니다. 구체적인 질문이 있으시면 언제든지 <a href="mailto:info@gaia3d.com">info@gaia3d.com</a>으로 이메일을 보내주십시오!
					</p>
				</div>
				<div>
					<div class="sub_title"><span id="License">mago3D.js, F4D Converter각 라이센스는 어떻게 사용해야 합니까?</span></div>
					<p>
						mago3D.js, F4D Converter 마다 라이센스가 다릅니다. mago3D.js는 아파치 라이센스라 누구든 자유롭게 사용하시면 됩니다. 소스코드는 공개하셔야 합니다.<br>
						F4D Converter 같은 경우에는 mago3D F4D 변환기 상업 ISV를위한 라이선스 및 VAR의
						Gaia3D는 오픈 소스 프로젝트 (예 : ISV 및 VAR의 등) 상업 유통의 개발 및 배포 요구를 충족하도록 설계된 듀얼 라이선스 모델에서의 mago3D F4D 변환기를 제공합니다. 
						<br>
						ISV는, VAR의 및 기타 상업 응용 프로그램의 유통 :
						ISV를 (독립 소프트웨어 공급 업체), VAR의 (부가 가치 리셀러)와 결합 mago3D F4D 변환기 소프트웨어와 상용 라이센스 소프트웨어를 배포하고, 소스 코드를 배포하지 않으 다른 유통 상업적으로 Gaia3D와 상용 라이센스 계약을 체결해야 GNU AFFERO 일반 공중 사용 허가서 (이하 "AGPL"https://www.gnu.org/licenses/agpl-3.0.en.html)의 버전 3에서 소프트웨어를 라이센스. 
						<br>
						오픈 소스 프로젝트 및 오픈 소스 응용 프로그램의 다른 개발자 용 :
						결합 mago3D F4D 변환기 소프트웨어와 그 FOSS 응용 프로그램을 배포 할 자유 오픈 소스 소프트웨어 ( "FOSS")는 GPL 또는 AGPL에 따라 응용 프로그램 개발자를 위해 Gaia3D의 오픈 소스 소프트웨어 라이센스 AGPL에서 최선의 선택입니다.
					</p>
				</div>
				<div>
				<div class="sub_title"><span id="mago3DJSbug">mago3DJS에서 버그를 발견했습니다. 어떻게 해야 합니까?</span></div>
					<p>
						모든 mago3DJS에 관련 버그를 <a href="https://github.com/Gaia3D/mago3djs/issues">mago3DJS issue tracker</a> 에 제출하십시오. 감사합니다!
					</p>
				</div>
				<div class="sub_title"><span id="mago3Dbug">mago3D 전체에서 버그를 발견하거나 다른 질문이 있는 경우에는 어떻게 해야 합니까?</span></div>
				<p>
					문제를 발견했거나 위에서 다룰 수 없는 다른 질문이 있으시면 <a href="mailto:info@gaia3d.com">info@gaia3d.com</a>으로 이메일을 보내주십시오.
				</p>
			</div>
		</div>
	</section>

	<footer style="margin-top: 63px;">
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
