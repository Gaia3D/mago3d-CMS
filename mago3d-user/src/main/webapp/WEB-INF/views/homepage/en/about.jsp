<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>about | mago3D User</title>
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
	</header>

	<nav class="nav">
		<div>
			<h1>
				<a href="/homepage/index.do">mago3D</a>
			</h1>
			<ul class="menu">
				<li class="mm on" onclick='selectMenu();'>mago3D<span></span>
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
				<li><a href="/homepage/faq.do">FAQ</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class=""><a href="/homepage/about.do" onclick ="changeLanguage('ko');">KO</a></li>
				<li id="languageEN" class="on">EN</li>
			</ul>
		</div>
	</nav>
	<section>
		<h2>mago3D</h2>
		<div class="contents">
			<ul class="tab">
				<li><a href="#about">About</a></li>
				<li><a href="#now">Now</a></li>
				<li><a href="#will">Will be</a></li>
			</ul>
			<div id="about" class="part">
				<h3>
					About<span></span>
				</h3>
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
							<a href="/homepage/demo.do">
								<span class="image left">
									<img src="/images/${lang}/homepage/gangbuk.png" 
									alt="3DS format has been uploaded to mago3D.">
								</span>
								<span class="description">
									<b>3DS</b>
								</span>
							</a>
						</div>
					</div>
					<div class="wrapper_demo">
						<div class="highlight two">
							<a href="/homepage/demo.do">
								<span class="image fit">
									<img src="/images/${lang}/homepage/Collada_model.png" 
									alt="COLLADA format is the screen which is uploaded to mago3D.">
								</span>
								<span class="description">
									<b>COLLADA</b>
								</span>
							</a>
						</div>
					</div>
					<div class="wrapper_demo">
						<div class="highlight three">
							<a href="/homepage/demo.do">
								<span class="image left">
									<img src="/images/${lang}/homepage/IFC_model.png" 
									alt="The IFC (BIM) format has been uploaded to mago3D.">
								</span>
								<span class="description ">
									<b>IFC(BIM)</b>
								</span>
							</a>
						</div>
					</div>
				</div>

				<h4>
					Supported formats<span></span>
				</h4>
				<table>
					<tr>
						<th>Format</th>
						<th>Details</th>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/IFC.png" alt="IFC(BIM) format image"/></td>
						<td>IFC(Industry Foundation Classes)<br/>- a commonly used collaboration format in Building information modeling(BIM).</td>
					</tr>

					<tr>
						<td><img src="/images/${lang}/homepage/obj.png" alt="OBJ format image"/></td>
						<td>Wavefront File Format Specification (OBJ) A three-dimensional file format that contains three-dimensional coordinates (polygonal lines and points), texture mapping, and other object information</td>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/3DS.png" alt="3DS format image"/></td>
						<td>3D Studio File Format (3DS)) File formats used in 3D Studio in AutoDesk</td>
					</tr>
					<tr>
						<td width="64px"><img src="/images/${lang}/homepage/dae.png" alt="COLLADA format image"></td>
						<td>COLLADA (COLLAborative Design Activity) - Open standard format based on XML Schema for exchanging 3D data</td>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/JT.png" alt="Jt format image"/></td> 
						<td>JT (Jupiter Tessellation) Lightweight 3D model format developed by Siemens PLM Software - Please contact us if you need JT format support</td>
					</tr>
				</table>
				<h4>Rendering Algoritm</h4>
				<div class="wrapper-algo">
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="Correct triangle vertex sequence images"
								style="background-image:url(/images/${lang}/homepage/triangle.png)">
								<div>
									<h3>Correct triangle vertex sequence</h3>
									<P>Performance enhancements supported by WebGL</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="Model/Reference images"
								style="background-image:url(/images/${lang}/homepage/model_reference.png)">
								<div>
									<h3>Model/Reference</h3>
									<P>Multi-instance lightweight technique</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="Create VBO  images"
								style="background-image:url(/images/${lang}/homepage/tri.jpg)">
								<div>
									<h3>Create VBO</h3>
									<P>Save sorted by triangle size</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="3D space Octree"
								style="background-image:url(/images/${lang}/homepage/octree.png)">
								<div>
									<h3>3D Space Octree</h3>
									<P>Flexible octree depth</P>
								</div>
							</div>
						</a>
					</div>
				</div>
				<div class="wrapper-algo">
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="Lego Strucure images"
								style="background-image:url(/images/${lang}/homepage/lego.png)">
								<div>
									<h3>Lego Strucure</h3>
									<P>Generate data for rougher LOD</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="Visibility Index images"
								style="background-image:url(/images/${lang}/homepage/indexing.png)">
								<div>
									<h3>Visibility Index</h3>
									<P>Pre-processing for occlusion</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="Raw data loading images"
								style="background-image:url(/images/${lang}/homepage/loading.png)">
								<div>
									<h3> Raw data loading </h3>
									<P>Applying loading time out</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="Bounding box images" style="background-image:url(/images/${lang}/homepage/boundingbox.png)">
								<div>
									<h3>Bounding box</h3>
									<P>Bounding box calculation</P>
								</div>
							</div>
						</a>
					</div>
				</div>
				<a href="#" class="goTop">goTop</a>
			</div>
			<!-- // ABOUT -->

			<div id="now" class="part">
				<h3>
					NOW<span></span>
				</h3>
				<h4>Architecture</h4>
				<p>
				mago3D is a spring framework (spring boot) based 3D platform. We use PostGis for processing spatial information, and use open source javascript library for cesium, worldwind for 3D rendering part.
				One of big hurdle to integrate AEC and 3D GIS simultaneously is handling and visualisation of massive 3D data. 
				To overcome this hurdle, new format called F4D has been devised adopting block reference concept. 
				Also a format converter that converts popular 3D format to F4D has been developed. 
				Currently industry standard IFC(Industry Foundation Classes), JT(Jupiter Tessellation), and popular 3D formats such as OBJ, 3DS, COLLADA DAE can be converted to F4D format. 
				F4D format coupled with mago3Djs(javascript library) has proven that it can increase memory management efficiency and rendering speed drastically. 
				mago3D can now visualise massive 3D data including indoor objects and AEC data at least 100k objects, in a single scene seamlessly with traditional outdoor 3D GIS objects.
				</p>
				<div class="architecture">
					<img src="/images/${lang}/homepage/arc.png"
						style="width: 590px; margin-top: 60px;" alt="mago3D 아키텍쳐"> <img
						src="/images/${lang}/homepage/sw.png" style="width: 590px;"
						alt="mago3D 소프트웨어 구성도">
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
						<img src="/images/${lang}/homepage/dashboard.png" alt="Dashboard on admin page"style="width: 800px; height: 500px;">
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
						<img src="/images/${lang}/homepage/issue.png" 
						alt="This is an image of the page that manages the issue on the manager page." style="width: 800px;">
					</div>
					<div class="colspan-2 column clear">
						<img src="/images/${lang}/homepage/data.png" 
						alt="This is an image of the page that manages the data on the admin page."style="width: 800px;">
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
						<td>3D object information PogstGIS interlock, RestAPI, caching function
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
					<li>This project is part of the Ministry of Land, Transport and Maritime Affairs, "Development of Open Source Processing Technology for Application of Spatial Information SW (Project Number: 17NSIP-B080778-04)".</li>
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
				Contact <span></span>
			</h2>
			<p>
				If you are interested in mago3D, please contact us by email or phone or visit us directly.
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
