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
<%-- 	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script> --%>
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
				<li id="languageEN"><a href="/homepage/faq.do" onclick="changeLanguage('en');">EN</a></li>
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
						mago3D는 AEC(Architecture, Engineering, Construction) 영역과 전통적인 3차원 공간정보(3D GIS)를 통합적으로 관리, 가시화해 주는 차세대 3차원 플랫폼입니다.
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
						mago3D.js는 Apache2.0, F4D Converter는 AGPL3.0을 기반으로 한 듀얼 라이센스를 따릅니다. 
						F4D 변환기를 사용하지만 소스 코드를 공개하지 않으려는 조직이나 개인은 Gaia3D(www.gaia3d.com)에서 상업용 라이센스를 취득해야 합니다. 
						상업용 라이센스를 제외하고 모두 AGPL3.0의 적용을받으며 소스 코드가 공개되어 있습니다. 더 자세한 사항은 <a href="mailto:info@gaia3d.com">info@gaia3d.com</a>으로 문의해 주시기 바랍니다.
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
