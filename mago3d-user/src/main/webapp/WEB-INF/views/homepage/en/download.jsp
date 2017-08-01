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
<!-- 		<div> -->
<!-- 			<p>Architecture, Engineering, Construction</p> -->
<!-- 			<p>A Brand-New Live 3D Platform</p> -->
<!-- 		</div> -->
	</header>
	
	<nav class="nav">
		<div>
			<h1>
				<a href="/homepage/index.do">mago3D</a>
			</h1>
			<ul class="menu">
				<li><a href="/homepage/about.do">mago3D</a></li>
				<li class="mm" onclick='selectMenu();'>Demo<span></span>
					<ul>
						<li><a href="/homepage/demo.do" style="color: white">Cesium</a></li>
						<li><a href="/homepage/demo.do?viewLibrary=worldwind"
							style="color: white">World Wind</a></li>
					</ul>
				</li>
				<li class="on">Download<span></span></li>
				<li><a href="/homepage/tutorials.do">Tutorials</a></li>
				<li class="mm" onclick='selectMenu();'>Docs
					<ul>
						<li><a href="/homepage/api.do" style="color: white">API</a></li>
						<li><a href="#" onclick='alert("Coming soon..."); return false;' style="color: white">F4D Spec</a></li>			
					</ul>
				</li>
			</ul>
			<ul class="language">
				<li id="languageKO"><a href="#" onclick="changeLanguage('ko');">KO</a></li>
				<li id="languageEN" class="on">EN</li>
			</ul>
		</div>
	</nav>

	<section>
		<h2>Download</h2>
		<div class="contents">
			<button type="button" class="down" onclick="location.href='https://github.com/Gaia3D/mago3d'">
				DOWNLOAD mago3D 1.0.0 <span>2017-07-01</span>
			</button>

			<h4>Added features</h4>
			<ul>
				<li>You can register various types of issues and see who, when,
					and where the issues are registered in the artifact list.</li>
				<li>A batch registration feature has been added. That allows
					you to quickly and easily upload more data using defined Excel
					file.</li>
				<li>To display object information display now available.</li>
				<li>Support API list to make it easier to use various APIs.</li>
			</ul>

			<h4>Quick Start Guide</h4>
			<ol>
				<li>Install mago3d.</li>
				<li>After installing, install was (tomcat), web server (nginx,
					apache), DataBase (PostgreSQL + PostGIS).</li>
				<li>Use was and web server to run mago3d.</li>
				<li>Mago3d Registers the data you want to use on the
					administrator's homepage by using registration or batch
					registration and registers necessary data.</li>
			</ol>
			<h4>Gaia3D's mago3D Software License:</h4>
			<b>1. F4D Converter: Dual License – Please see below for more
				details.</b><br>
			<br>
			<p>
				<i>mago3D F4D Converter Commercial License for OEMs, ISVs and
					VARs</i><br>Gaia3D provides its mago3D F4D Converter under a dual
				license model designed to meet the development and distribution
				needs of both commercial distributors (such as OEMs, ISVs and VARs)
				and open source projects.<br> <br> <i>For OEMs, ISVs,
					VARs and Other Distributors of Commercial Applications:</i><br>
				OEMs (Original Equipment Manufacturers), ISVs (Independent Software
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
			<b>2. mago3D.js: Apache License</b><br>
			<h4>Documentation</h4>
			<table>
				<tr>
					<th>JS Document</th>
					<th>Convert Document</th>
				</tr>
				<tr>
					<td><a href="#" onclick='alert("Coming soon..."); return false;'>mago3Djs-1.0.0 js Document</a></td>
					<td><a href="#" onclick='alert("Coming soon..."); return false;'>F4DConverter-1.0.0 Document</a></td>
				</tr>
			</table>

			<h4>Source</h4>
			<table>
				<tr>
					<th>Version</th>
					<th>Download</th>
					<th>Date</th>
					<th>GitHub</th>
				</tr>
				<tr>
					<td>1.0.0</td>
					<td><a href="#" onclick='alert("Coming soon...")'>Mago3Dall.zip</a></td>
					<td>2017-07-01</td>
					<td>
						<ul>
							<li><a href="https://github.com/Gaia3D/mago3djs">mago3D.js</a></li>
							<li><a href="#" onclick='alert("Coming soon..."); return false;'>F4D Converter</a></li>
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
			<p>If you are interested in Mago3D, please contact us by email or
				phone or visit us directly.</p>
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
