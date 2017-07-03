<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <title>download | mago3D User</title>
    <!--[if lt IE 9]>
    	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!--[if lt IE 8]>
    	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css"/>
	<script type="text/javascript" src="/js/analytics.js"></script>
	<script type="text/javascript" src="/js/${lang }/common.js"></script>
	<script type="text/javascript" src="/js/${lang }/message.js"></script>
</head>

<body>
	<nav class="nav">
		<div>
			<h1><a href="./index.do">mago3D</a></h1>
			<ul class="menu">
				<li><a href="/homepage/about.do">mago3D</a></li>
				<li><a href="/homepage/demo.do">Demo</a></li>
				<li class="on">Download<span></span></li>
				<li><a href="/homepage/tutorials.do">Tutorials</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO"><a href="" onclick ="changeLanguage('ko');">KO</a></li>
				<li id="languageEN" class="on"><a href="" onclick ="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	
	<section>
		<div class="contents">

			<button type="button" class="down" onclick='alert("Coming soon...")'>
				DOWNLOAD Mago3D 1.0.0
				<span>123.5 MB</span>
				<span>2017-07-01</span>
			</button>

			<h4>Added features</h4>
			<ul>
				<li>You can register various types of issues and see who, when, and where the issues are registered in the artifact list.</li>
				<li>A batch registration feature has been added. That allows you to quickly and easily upload more data using defined Excel file.</li>
				<li>To display object information display now available.</li>
				<li>Support API list to make it easier to use various APIs.</li>
			</ul>
            <h4>Quick Start Guide</h4>
            <ol>
                <li>Install mago3d.</li>
                <li>After installing, install was (tomcat), web server (nginx, apache), DataBase (PostgreSQL + PostGIS).</li>
                <li>Use was and web server to run mago3d.</li>
                <li>Mago3d Registers the data you want to use on the administrator's homepage by using registration or batch registration and registers necessary data.</li>
            </ol>
			<h4>Documentation</h4>
			<table>
				<tr>
					<th>JS Document</th>
					<th>Convert Document</th>
					<th>Biz Document</th>
				</tr>
				<tr>
					<td><a href="#" onclick='alert("Coming soon...")'>Mago3Djs-1.0.0 js Document</a></td>
					<td></td>
					<td></td>
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
							<li><a href="https://github.com/Gaia3D/mago3djs">mago3djs</a></li>
							<li><a href="#" onclick='alert("Coming soon...")'>mago3dconver</a></li>
							<li><a href="#" onclick='alert("Coming soon...")'>mago3dbiz</a></li>
						</ul>
					</td>
				</tr>
			</table>

		</div>
	</section>

	<footer>
		<div>
			<h2>
				Contact
				<span></span>
			</h2>
			<p>
				If you are interested in Mago3D, please contact us by email or phone or visit us directly.
			</p>
			<ul class="contact">
				<li class="company">www.gaia3d.com</li>
				<li class="address">080 2 3397 3475</li>
				<li class="mail">mago3d@gaia3d.com</li>
			</ul>
			<p class="copyright">
				&copy; 2017. Mago3D all rights reserved.
			</p>
		</div>
	</footer>
</body>


</html>
