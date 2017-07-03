<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <title>about | mago3D User</title>
    <!--[if lt IE 9]>
    	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<header>
		<div>
			<p>Architecture, Engineering, Construction</p>
			<p>A Brand-New Live 3D Platform</p>
		</div>
	</header>

	<nav class="nav">
		<div>
			<h1><a href="./index.do">mago3D</a></h1>
			<ul class="menu">
				<li class="on">mago3D</li>
				<li><a href="/homepage/demo.do">Demo</a></li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li><a href="/homepage/tutorials.do">Tutorials</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on"><a href="" onclick ="changeLanguage('ko');">KO</a></li>
				<li id="languageEN"><a href="" onclick ="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="contents">
			<ul class="tab">
				<li><a href="#about"></a>About</li>
				<li><a href="#now">Now</a></li>
				<li><a href="#will">Will be</a></li>
			</ul>
			<div id="about" class="part">
				<h3>About</h3>
				<p>
mago3D could seamlessly integrate AEC(Architecture, Engineering, Construction) and 3D GIS in web browser using Cesium or Web World Wind.
Although there has been numerous attempts to integrate AEC and 3D GIS on a single geospatial platform, the outcome of these attempts are not so satisfactory till to date. 
Difference of data model, massive number of data to be rendered, big volume of file size are among those major technical barriers that hindered seamless integration of indoor and outdoor space.
				</p>
				<h4>Features of mago3D</h4>
				<ul>
					<li>Integration of 3D GIS with BIM / AEC</li>
					<li>Seamless integration of indoor and outdoor spaces (seamless integration of indoor & outdoor space)</li>
					<li>Runs on a web browser and does not require a separate plug-in or ActiveX installation</li>
					<li>It is open source based on open source (Cesium, World Wind) and has excellent openness and scalability.</li>
					<li>Efficient management and ultra-fast rendering of high-capacity 3-D files</li>
				</ul>			
				<div class="row_demo">
					<div class="wrapper_demo">
						<div class="highlight">
							<a href="#">
								<span class="image left">
									<img src="/images/${lang}/homepage/gangbuk.png">
								</span>
								<div class="description">
									<h2>3DS</h2>
									<p>3DS Modeling</p>
								</div>
							</a>
						</div>
					</div>
					<div class="wrapper_demo">
						<div class="highlight two">
							<a href="#">
								<span class="image fit">
									<img src="/images/${lang}/homepage/Collada_model.png">
								</span>
								<div class="description">
									<h2>COLLADA</h2>
									<p>COLLADA Modeling</p>
								</div>
							</a>
						</div>
					</div>
					<div class="wrapper_demo">
						<div class="highlight three">
							<a href="#">
								<span class="image left">
									<img src="/images/${lang}/homepage/IFC_model.png">
								</span>
								<div class="description ">
									<h2>IFC</h2>
									<p>IFC Modeling</p>
								</div>
							</a>
						</div>
					</div>
				</div>
				
				<h4>Supported formats<span></span></h4>
				<table>
					<tr>
						<th>Format</th> <th>Details</th>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/IFC.png"/></td> <td>IFC(Industry Foundation Classes)<br/>- a commonly used collaboration format in Building information modeling(BIM).</td>
					</tr>

					<tr>
						<td><img src="/images/${lang}/homepage/obj.png"/></td> <td>OBJ(Wavefront file format specification)<br/>- a geometry definition file format adopted by other 3D graphics application vendors.</td>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/3DS.png"/></td> <td>3DS(3D-Studio File Format)<br/>- an import/export format used by the Autodesk 3ds Max 3D modeling, animation and rendering software.</td>
					</tr>
					<tr>
						<td width="64px"><img src="/images/${lang}/homepage/dae.png"></td> <td>COLLADA(COLLAborative Design Activity)<br/>- an interchange file format for exchanging digital assets among various graphics software applications.</td>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/JT.png"/></td> <td>JT(Jupiter Tesselation)<br/>- an ISO-standardized 3D data format and is in industry used for product visualization, collaboration, CAD data exchange, and in some also for long-term data retention.
						- If you want to use it, please contact the company.</td>
					</tr>
				</table>
				<a href="#" class="goTop">goTop</a>
			</div>
      
			<!-- // ABOUT -->

			<div id="now" class="part">
				<h3>NOW<span></span></h3>
				<h4>Architecture</h4>
				<p>
				mago3D based on spring framework (springboot). We use PostGis for processing spatial information, and use open source javascript library for cesium, worldwind for 3D rendering part.
				One of big hurdle to integrate AEC and 3D GIS simultaneously is handling and visualisation of massive 3D data. 
				To overcome this hurdle, new format called F4D has been devised adopting block reference concept. 
				Also a format converter that converts popular 3D format to F4D has been developed. 
				Currently industry standard IFC(Industry Foundation Classes), JT(Jupiter Tessellation), and popular 3D formats such as OBJ, 3DS, COLLADA DAE can be converted to F4D format. 
				F4D format coupled with mago3Djs(javascript library) has proven that it can increase memory management efficiency and rendering speed drastically. 
				mago3D can now visualise massive 3D data including indoor objects and AEC data at least 100k objects, in a single scene seamlessly with traditional outdoor 3D GIS objects.
				</p>
				<div class="architecture">
					<img src="/images/${lang}/homepage/arc.png" style="width: 590px; margin-top: 60px;">
					<img src="/images/${lang}/homepage/sw.png" style="width: 590px;">
				</div>
				
				<a href="#" class="goTop">goTop</a>
			</div>
      
			<!-- // NOW -->

			<div id="will" class="part">
				<h3>
					Will be<span></span>
				</h3>
				<h4>3d integrated control &amp; issue management system</h4>
				<p>There are sites for administrators and general users,
					provides the following features.</p>
				<div class="wrap">
					<div class="colspan-2 column">
						<img src="/images/${lang}/homepage/dashboard.png">
					</div>
					<div class="colspan-1 column">
						<h2>Admin page</h2>
						<p>DashBoard is on the admin page. You can see various issues
							such as new issues, ongoing issues, and completed issues at a
							glance. In case of DB, you can easily manage DB Connection Pool
							status and DB session status. In addition, user status, schedule
							execution history, and user tracking are provided to manage
							users.</p>
					</div>
					<div class="colspan-1 column text-left clear">
						<h2>Issue management</h2>
						<p>
							This page is that manages the issue. You can see the current
							issue status in the issue list. You can get various information
							such as registration date, deadline status, and type of the
							issue. The issue can be <b> edited / deleted </b>. <br> In
							Issue Registration, register an issue by stating the required
							items such as issue type, title, and content.
						</p>
					</div>
					<div class="colspan-2 column text-left">
						<img src="/images/${lang}/homepage/issue.png">
					</div>
					<div class="colspan-2 column clear">
						<img src="/images/${lang}/homepage/data.png">
					</div>
					<div class="colspan-1 column">
						<h2>Data management</h2>
						<p>
							This page is that manages the data. You can see the current
							status of the data in the data list. Data can be registered one
							by one on the registration page, but batch registration is
							possible in Excel format. Data modify/delete/lock function and
							many other features are provided. <br> In data groups, you
							can group data.
						</p>
					</div>
				</div>
				<h4>Additional features</h4>
				<table>
					<tr>
						<td>Admin DashBoard page</td>
						<td>Role based access-control of user groups</td>
					</tr>
					<tr>
						<td>PogstGis with 3D object information, support caching.<br />REST
							API that provides API for 3D data sending and receiving.
						</td>
						<td>Converting to F4D format</td>
					</tr>
					<tr>
						<td>Issue status(New, ongoing, and completed issues)</td>
						<td>Status graph by user</td>
					</tr>
					<tr>
						<td>DB Connection Pool status, DB Session status</td>
						<td>Statistics and history</td>
					</tr>
					<tr>
						<td>Schedule</td>
						<td></td>
					</tr>
				</table>
				<h4>Cloud environment</h4>
				<p>We will provide Amazon, Google, Azure and other cloud services.
				Users can check it in real time in mago3D, after uploading files(jt,obj,collada, etc.) in the cloud environment. 
				</p>
				<h4>Acknowledgement</h4>
				<ul>
					<li>Ministry of Land, Transport and Maritime Affairs "Development of open source processing technology for application of spatial information SW (Project number: 16NSIP-B080778-04)".</li>
					<li>The 3D data of Seoul is being used for research purpose under the permission of Korea Spatial Informaiton Industry Promotion Institute.</li>
					<li>The indoor data of Seoul is being used for research purposes under the permission of Seoul Metropolitan Government.</li>
					<li>Other datas will be provided with the permission of each copyright holder.</li>
				</ul>
				<a href="#" class="goTop">goTop</a>
			</div>
			<!-- // WILL -->

		</div>
	</section>

	<footer>
		<div>
			<h2>
				Contact
				<span></span>
			</h2>
			<p>
				If you are interested in mago3D, please contact us by email or phone or visit us directly.
			</p>
			<ul class="contact">
				<li class="company">www.gaia3d.com</li>
				<li class="address">+82-(0)2-3397-3475</li>
				<li class="mail">info@gaia3d.com</li>
			</ul>
			<p class="copyright">
				&copy; 2017 Gaia3D, Inc.
			</p>
		</div>
	</footer>
</body>


</html>
