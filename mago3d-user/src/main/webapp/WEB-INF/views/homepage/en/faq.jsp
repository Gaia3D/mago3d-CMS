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
						<li><a href="/homepage/news.do" style="color: white" onclick="alert('Coming soon.'); return false">News</a></li>
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
				<li id="languageKO"><a href="#" onclick="changeLanguage('ko');">KO</a></li>
				<li id="languageEN" class="on">EN</li>
			</ul>
		</div>
	</nav>
	<section>
		<h2 style="margin-bottom: 5px;">FAQ</h2>
		<div class="line"></div>
		<div class="contents">
			<div id="faq_menu" style="margin-bottom: 50px;">
				<ul>
					<li><a href="#mago3D">What is mago3D?</a></li>
					<li><a href="#browser">Which browsers do you support?</a></li>
					<li><a href="#jtformat">I want to use the JT format. What should I do?</a></li>
					<li><a href="#License">Mago3DJS, F4D Converter How do I use each license?</a></li>
					<li><a href="#mago3DJSbug">I found a bug in mago3DJS. What should I do?</a></li>
					<li><a href="#mago3Dbug">What should I do if I find bugs or have other questions throughout mago3D?</a></li>
				</ul>
			</div>
			<div id="faq_main">
				<div>
					<div class="sub_title"><span id="mago3D">What is mago3D?</span></div>
					<p>	 
						MAGO3D is a next-generation 3D platform that integrates and visualizes AEC (Architecture, Engineering, Construction) and traditional 3D spatial information (3D GIS).
					</p>
				</div>
				<div>
					<div class="sub_title"><span id="browser">Which browsers do you support?</span></div>
					<p>	
						This demo page is optimized for the Chrome browser for high-volume web data processing. Please use the Chrome browser for smooth service.
					</p>
				</div>	
				<div>
					<div class="sub_title"><span id="jtformat">I want to use the JT format. What should I do?</span></div>
					<p>
						You must contact the company separately for the JT format. If you have any specific questions, feel free to email <a href="mailto:info@gaia3d!">info@gaia3d!</a>
					</p>
				</div>
				<div>
					<div class="sub_title"><span id="License">Mago3D.js, F4D Converter How do I use each license?</span></div>
					<p>
						<i>mago3D F4D Converter Commercial License for ISVs and
						VARs</i><br>Gaia3D provides its mago3D F4D Converter under a dual
						license model designed to meet the development and distribution
						needs of both commercial distributors (such as ISVs and VARs)
						and open source projects.<br> <br> <i>For ISVs,
							VARs and Other Distributors of Commercial Applications:</i><br>
						ISVs (Independent Software
						Vendors), VARs (Value Added Resellers) and other distributors that
						combine and distribute commercially licensed software with mago3D
						F4D Converter software and do not wish to distribute the source code
						for the commercially licensed software under version 3 of the GNU
						AFFERO GENERAL PUBLIC LICENSE (the "AGPL"
						https://www.gnu.org/licenses/agpl-3.0.en.html ) must enter into a
						commercial license agreement with Gaia3D.<br>
						<br> <i>For Open Source Projects and Other Developers of
							Open Source Applications:</i><br> For developers of Free Open
						Source Software ("FOSS") applications under the GPL or AGPL that
						want to combine and distribute those FOSS applications with mago3D
						F4D Converter software, Gaia3D’s open source software licensed under
						the AGPL is the best option.					
					</p>
				</div>
				<div>
				<div class="sub_title"><span id="mago3DJSbug">I found a bug in mago3DJS. What should I do?</span></div>
					<p>
						Submit all relevant bugs to all mago3DJS on the <a href="https://github.com/Gaia3D/mago3djs"> mago3DJS issue tracker </a>. Thank you!
					</p>
				</div>
				<div class="sub_title"><span id="mago3Dbug">What should I do if I find bugs or have other questions throughout mago3D?</span></div>
					<p>
						If you've found a problem or have any other questions you can not address above, please email <a href="mailto:info@gaia3d.com"> info@gaia3d.com </a>.
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
