<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
<meta charset="utf-8">
<meta id="viewport" content="width=1250">
<title>API | mago3D User</title>
<!--[if lt IE 9]>
	   	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
<link rel="stylesheet" href="/externlib/${lang}/highlight/styles/agate.css" />
<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
<link rel="stylesheet" href="/css/${lang}/font/font.css" />
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/analytics.js"></script>
<script type="text/javascript" src="/externlib/${lang}/highlight/highlight.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
<script>
// 	$(document).ready(function(){
// 		$("a.api").on('click', function (event){
// 			event.preventDefault();
// 			$("#content").load($(this).attr('href'));
// 		});
// 	});
	</script>
</head>
<body>
	<div id="wrap">
		<div class="navigation">
			<h3 class="application_name">
				<a href="/homepage/about.do">mago3D.JS</a>
			</h3>
			<div class="search">
				<input id="search" type="text" class="form-control input-sm" placeholder="Search Documentations">
			</div>
			<ul class="list">
				<li class="item"><span class="api_title"> <a class="api" href="#changeMagoStateAPI">changeMagoStateAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeBoundingBoxAPI">changeBonudingBoxAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeShadowAPI">changeShadowAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeFrustumFarDistanceAPI">changeFrustumFarDistanceAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#searchDataAPI">searchDataAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeColorAPI">changeColorAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeLocationAndRotationAPI">changeLocationAndRotationAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeMouseMoveAPI"> changeMouseMoveAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeInsertIssueModeAPI">changeInsertIssueModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeObjectInfoViewModeAPI">changeObjectInfoViewModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeListIssueViewModeAPI">changeListIssueViewModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#drawInsertIssueImageAPI">drawInsertIssueImageAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeInsertIssueStateAPI">changeInsertIssueStateAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#mouseMoveAPI">mouseMoveAPI</a>
				</span></li>
			</ul>
		</div>
		<div class="main" id="content">
			<div class="header">
				<h2>mago3D.JS V1.0.0</h2>
				<img src="/images/${lang}/homepage/AC.png" style="margin-bottom: 10px;" />
			</div>
			<article class="readme">
				<img src="https://img.shields.io/badge/language-English-orange.svg" /> <img src="https://img.shields.io/badge/language-Korean-blue.svg" />
				<p>
MAGO3D is a next-generation 3D platform that integrates and visualizes AEC (Architecture, Engineering, Construction) and traditional 3D spatial information (3D GIS). Unlike existing solutions, MAGO3D seamlessly integrates AEC and 3D GIS in a web browser without distinction between indoor and outdoor. As a result, MAGO3D users can quickly view and collaborate on large-capacity building information modeling (BIM), JT (Jupiter Tessellation) and 3D GIS files without installing any additional programs.<p>
				<h4>Mssion</h4>
				<p>Mago3DJS Visualization using open source JavaScript library for three-dimensional multi-block visualization Data integration task | You can manage issues.</p>
				<h4>Features</h4>
				<ul class="readme_list">
					<li>Issue Status You can view new issues, ongoing issues, and completed issues.</li>
					<li>It is easy to view the status by user status graph.</li>
					<li>DB Connection Pool status or DV session status can be viewed as a table.</li>
				</ul>
				<h4>Development Environment</h4>
				<mark>Spring, gradle, PostgreSQL, PostGIS, mybatis, Docker</mark>
				<h4>Getting Started</h4>
				<div class="list_wrap">
					<div class="sub_title">Install</div>
					<ul class="readme_list">
						<li><b style="color: #1E90FF;">Postgres</b>
							<ul class="sub_list">
								<li>Setting PostgreSQL Version (PostgreSQL v9.6.3-1)</li>
								<li>Installation path C:/PostgreSQL</li>
								<li>Setting Password: postgres Retype Password: postgres</li>
							</ul>
						</li>
						<li><b style="color: #1E90FF;">PostGIS</b>
							<ul class="sub_list">
								<li>After installing PostgreSQL, run Stack Builder to install</li>
								<li>PostGIS version setting (PostGIS v2.3.2)</li>
								<li>PostgreSQL Extensions PostGIS Required</li>
							</ul>
						</li>
						<li><b style="color: #1E90FF;">gradle</b>
							<ul class="sub_list">
								<li>Installing the gradle version (gradle v3.5)</li>
								<li>Installation path C:/gradle</li>
								<li>Adding System Variables-path -> C:/gradle/gradle-3.5 add</li>
						
							</ul>
						</li>
						<li><b style="color: #1E90FF;">lombok</b>
							<ul class="sub_list">
								<li>After installation, move the download folder and run</li>
								<li>Locate the eclipse installation location [Specify location ..] and select the file 'eclipse.exe'.</li>
								<li>Click install / update.</li>
							</ul>
						</li>
						<li><b style="color: #1E90FF;">Buildship Gradle Integration</b>
							<ul class="sub_list">
								<li>Go to eclipse Help -> Eclipse Marketplace and install Buildship Gradle Integration 2.0.</li>
							</ul>
						</li>
					</ul>
					<div class="sub_title">Setting</div>
					<ul class="readme_list">
						<li>From eclipse, load the mago3D Project into git clone.</li>
						<li>Click File -> Import -> Gradle -> Existing Gradle Project to accept mago3D.</li>
						<li>Create a database using PostgreSQL before running mago3D.</li>
						<li>PostgreSQL -> new DataBase</li>
						<li>Run the query on the generated database. The query is in mago3D-core -> src -> doc -> database.</li>
					</ul>
					<pre>
						<code>
	name: mago3d
	Encoding: UTF8
	Template: template0
	Collation: C
	Character_type: C
	Connection_Limit: -1
						</code>
					</pre>
					<div class="sub_title">Execution</div>
					<ul class="readme_list">
						<li>To run mago3D, run mago3d - @@@ -> src / main / java -> com.gaia3d -> Mago3dAdminApplication.java as Spring Boot app.</li>
					</ul>
				</div>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeMagoStateAPI">changeMagoStateAPI()</span></h2>
				<p>Mago3D The mago3D Object is displayed and hidden on the screen by changing the activation status value.</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>isShow</td>
							<td>True: enabled, false: disabled</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;mago3D
	&lt;input type="radio" id="magoEnable" name="magoState" value="0" checked="checked" onclick="changeMagoState(true);" /&gt;
	&lt;label for="magoEnable"&gt; enabled &lt;/label&gt;
	&lt;input type="radio" id="magoDisable" name="magoState" value="1"  onclick="changeMagoState(false);" /&gt;
	&lt;label for="magoDisable"&gt; disabled &lt;/label&gt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function changeMagoStateAPI(isShow) {
	var api = new API("changeMagoState");
	api.setMagoEnable(isShow);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
			</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeBoundingBoxAPI">changeBoundingBoxAPI()</span></h2>
				<p>Set whether to display the BoundingBox of the block</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>isShow</td>
							<td>true: enabled, false: disabled</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;BoundingBox
	&lt;input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBoxAPI(true);" /&gt;
	&lt;label for="showBoundingBox"&gt; enabled &lt;/label&gt;
	&lt;input type="radio" id="hideBoundingBox" name="boundingBox" value="false"  onclick="changeBoundingBoxAPI(false);" /&gt;
	&lt;label for="hideBoundingBox"&gt; disabled &lt;/label&gt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code class="javascript">
function changeBoundingBoxAPI(isShow) {
	var api = new API("changeBoundingBox");
	api.setShowBoundingBox(isShow);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
			</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeShadowAPI">changeShadowAPI()</span></h2>
				<p>Structure / Outfitting of the block</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>isShow</td>
							<td>true: enabled, false: disabled</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;Shadow
	&lt;input type="radio" id="showShadow" name="shadow" value="true" onclick="changeShadowAPI(true);" /&gt;
	&lt;label for="showShadow"&gt; enabled &lt;/label&gt;
	&lt;input type="radio" id="hideShadow" name="boundingBox" value="false"  onclick="changeShadowAPI(false);" /&gt;
	&lt;label for="hideShadow"&gt; disabled &lt;/label&gt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function changeShadowAPI(isShow) {
	var api = new API("changeShadow");
	api.setShowShadow(isShow);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeFrustumFarDistanceAPI">changeFrustumFarDistanceAPI()</span></h2>
				<p>Set the Frustum Culling distance using the square of the input distance.</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>frustumFarDistance</td>
							<td>Frustum street. Internally, the square of the input value is used</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;label for="frustumFarDistance"&gt; Visible distance &lt;/label&gt;
&lt;input type="text" id="frustumFarDistance" name="frustumFarDistance" placeholder="Meter(m)" size=4" /&gt;
&lt;button type="button" id="changeFrustumFarDistanceAPI" class="btn btn-default btn-sm">apply/&gt;button%lt;
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function changeFrustumFarDistanceAPI(frustumFarDistance) {
	var api = new API("changefrustumFarDistance");
	api.setFrustumFarDistance(frustumFarDistance);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="searchDataAPI">searchDataAPI()</span></h2>
				<p>Enter the data unique key to move the camera position.</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>dataKey</td>
							<td>The blockId you want to search</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;
	&lt;span  style="padding-left: 10px; padding-right: 100px;"&gt;Data Key&lt;/span&gt;
	&lt;input type="text" id="search_data_key" name="search_data_key" size="15" /&gt;
	&lt;button type="button" id="searchData" style="width: 50px; background: #727272; font-size: 1.2rem;">search/&gt;button%lt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function searchDataAPI(dataKey) {
	var api = new API("searchData");
	api.setDataKey(dataKey);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeColorAPI">changeColorAPI()</span></h2>
				<p>
					It displays the input object as the input color. <br> It is possible to input multiple object information separated by ','.
				</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>objectIds</td>
							<td>Object id. In a plurality of cases,</td>
						</tr>
						<tr>
							<td>color</td>
							<td>R, G, and B colors are connected to ','</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;
	&lt;label for="objectIds"&gt;Object Id input &lt;/label&gt;
	&lt;input type="text" id="objectIds" name="objectIds" placeholder=", Enter segment" size=21" /&gt;
	&lt;button type="button" id="changeColorAPI" class="btn btn-default btn-sm">change/&gt;button%lt;
&lt;div/&gt;
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function changeColorAPI(objectIds, color) {
	var api = new API("changeColor");
	api.setObjectIds(objectIds);
	api.setColor(color);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeLocationAndRotationAPI">changeLocationAndRotationAPI()</span></h2>
				<p>The block is converted by the input position information and rotation information.</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>data_key</td>
							<td>object id</td>
						</tr>
						<tr>
							<td>latitude</td>
							<td>latitude</td>
						</tr>
						<tr>
							<td>longitude</td>
							<td>longitude</td>
						</tr>
						<tr>
							<td>height</td>
							<td>height</td>
						</tr>
						<tr>
							<td>heading</td>
							<td>left, right</td>
						</tr>
						<tr>
							<td>pitch</td>
							<td>uo, down</td>
						</tr>
						<tr>
							<td>roll</td>
							<td>left, right roll</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;Location And Rotation
	&lt;div&gt;
		&lt;span&gt;
			&lt;label for="move_data_key"&gt;Data Key &lt;/label&gt;
			&lt;input type="text" id="move_data_key" name="move_data_key" size="15" /&gt;
		&lt;/span&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;span&gt;
			&lt;label for="move_latitude"&gt;latitude&lt;/label&gt;
			&lt;input type="text" id="move_latitude" name="move_latitude" size="15" /&gt;
		&lt;/span&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;span&gt;
			&lt;label for="move_longitude"&gt;longitude&lt;/label&gt;
			&lt;input type="text" id="move_longitude" name="move_longitude" size="15" /&gt;
		&lt;/span&gt;
	&lt;/div&gt;	
	.
	.
	.
	&lt;div&gt;
		&lt;span&gt;
			&lt;label for="move_roll"&gt;ROLL&lt;/label&gt;
			&lt;input type="text" id="move_roll" name="move_roll" size="15" /&gt;
			&lt;button type="button" id="changeLocationAndRotationAPI">change/&gt;button%lt;
		&lt;/span&gt;
	&lt;/div&gt;		
&lt;/div&gt;
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function changeLocationAndRotationAPI(data_key, latitude, longitude, height, heading, pitch, roll) {
	var api = new API("changeLocationAndRotation");
	api.setDataKey(data_key);
	api.setLatitude(latitude);
	api.setLongitude(longitude);
	api.setElevation(height);
	api.setHeading(heading);
	api.setPitch(pitch);
	api.setRoll(roll);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeMouseMoveAPI">changeMouseMoveAPI()</span></h2>
				<p>Change mouse click target to move object</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>mouseMoveMode</td>
							<td>0 is full, 1 is object</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;Mouse movement mode
	&lt;div&gt;
		&lt;input type="radio" id="mouseBlockMove" name="mouseBlockMove" value="0" onclick="changeMouseMove('0')"/&gt;
		&lt;label for="mouseBlockMove"&gt;Block&lt;/label&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;input type="radio" id="mouseBlockMove" name="mouseBlockMove" value="0" onclick="changeMouseMove('0')"/&gt;
		&lt;label for="mouseBlockMove"&gt;Block&lt;/label&gt;
	&lt;/div&gt;		
&lt;/div&gt;	
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function changeMouseMoveAPI(mouseMoveMode) {
	var api = new API("changeMouseMove");
	api.setMouseMoveMode(mouseMoveMode);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeInsertIssueModeAPI">changeInsertIssueModeAPI()</span></h2>
				<p>Whether issue registration activation</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>flag</td>
							<td>true = enable, false = disable</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
준비중
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function changeInsertIssueModeAPI(flag) {
	var api = new API("changeInsertIssueMode");
	api.setIssueInsertEnable(flag);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeObjectInfoViewModeAPI">changeObjectInfoViewModeAPI()</span></h2>
				<p>Whether object information display is enabled</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>flag</td>
							<td>true = enable, false = disable</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
$("#objectInfoEnable").click(function() {
		if(objectInfoViewFlag) {
			objectInfoViewFlag = false;
			$("#objectInfoEnable").removeClass("on");
		} else {
			objectInfoViewFlag = true;
			$("#objectInfoEnable").addClass("on");			
		}
		changeObjectInfoViewModeAPI(objectInfoViewFlag);
	});
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function changeObjectInfoViewModeAPI(flag) {
	var api = new API("changeObjectInfoViewMode");
	api.setObjectInfoViewEnable(flag);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeListIssueViewModeAPI">changeListIssueViewModeAPI()</span></h2>
				<p>With now_latitude, now_longitude, finds the nearest group location in the data group, and retrieves and displays 100 issues belonging to that data group.</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>flag</td>
							<td>true = enable, false = disable</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;button id="issuesEnable"&gt;Issues Display&lt;/button&gt;
			&lt;input type="hidden" id="now_latitude" name="now_latitude" value="${now_latitude }" /&gt;
			&lt;input type="hidden" id="now_longitude" name="now_longitude" value="${now_longitude }"  /&gt;
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function changeListIssueViewModeAPI(flag) {
	var api = new API("changeListIssueViewMode");
	api.setIssueListEnable(flag);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="drawInsertIssueImageAPI">drawInsertIssueImageAPI()</span></h2>
				<p>Picture of pin image</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>drawType</td>
							<td>Image type 0: DB, 1: Issue registration</td>
						</tr>
						<tr>
							<td>issue_id</td>
							<td>Issue unique key</td>
						</tr>
						<tr>
							<td>issue_type</td>
							<td>Issue unique key</td>
						</tr>
						<tr>
							<td>data_key</td>
							<td>data unique key</td>
						</tr>
						<tr>
							<td>latitude</td>
							<td>data unique key</td>
						</tr>
						<tr>
							<td>longitude</td>
							<td>data unique key</td>
						</tr>
						<tr>
							<td>height</td>
							<td>data unique key</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
						// pin image images
						drawInsertIssueImageAPI(1, msg.issue.issue_id, msg.issue.issue_type, $("#data_key").val(),
						 $("#latitude").val(), $("#longitude").val(), $("#height").val());
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function drawInsertIssueImageAPI(drawType, issue_id, issue_type, data_key, latitude, longitude, height) {
	var api = new API("drawInsertIssueImage");
	api.setDrawType(drawType);
	api.setIssueId(issue_id);
	api.setIssueId(issue_type);
	api.setDataKey(data_key);
	api.setLatitude(latitude);
	api.setLongitude(longitude);
	api.setElevation(height);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeInsertIssueStateAPI">changeInsertIssueStateAPI()</span></h2>
				<p>Issue registration geo information related status change</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>insertIssueState</td>
							<td>Issue registration coordinate status</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>javaScript</b>
				<pre>
<code>
function changeInsertIssueStateAPI(insertIssueState) {
	var api = new API("changeInsertIssueState");
	api.setInsertIssueState(insertIssueState);
	if(managerFactory != null) {
		managerFactory.callAPI(api);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="mouseMoveAPI">mouseMoveAPI()</span></h2>
				<p>Replace with button event in mouse disabled environment</p>
				<h4>Parameters:</h4>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>eventType</td>
							<td>Identify which mouse actions you want</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>

&lt;ul class="controlStick"&gt;
		&lt;li&gt;
			&lt;span id="moveForwardImage"&gt;&lt;img src="/images/ko/plus.png" alt="plus" /&gt;&lt;/span&gt;
			&lt;span id="moveRightImage"&gt;&lt;img src="/images/ko/rotate_right.png" alt="rotate right" /&gt;&lt;/span&gt;
			&lt;span id="moveUpImage"&gt;&lt;img src="/images/ko/pitch_up.png" alt="plus" /&gt;&lt;/span&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;span id="moveBackwardImage"&gt;&lt;img src="/images/ko/minus.png" alt="minus" /&gt;&lt;/span&gt;
			&lt;span id="moveLeftImage"&gt;&lt;img src="/images/ko/rotate_left.png" alt="rotate left" /&gt;&lt;/span&gt;
			&lt;span id="moveDownImage"&gt;&lt;img src="/images/ko/pitch_down.png" alt="down" /&gt;&lt;/span&gt;
		&lt;/li&gt;
	&lt;/ul&gt;

$("#moveForwardImage").click(function() {
		mouseMoveAPI("moveForward");
	});
	$("#moveBackwardImage").click(function() {
		mouseMoveAPI("moveBackward");
	});
	$("#moveRightImage").click(function() {
		mouseMoveAPI("moveRight");
	});
	$("#moveLeftImage").click(function() {
		mouseMoveAPI("moveLeft");
	});
	$("#moveUpImage").click(function() {
		mouseMoveAPI("moveUp");
	});
	$("#moveDownImage").click(function() {
		mouseMoveAPI("moveDown");
	});


</code>
			</pre>
				<br> <b>javaScript</b>
				<pre>
<code>
function mouseMoveAPI(eventType) {
	if(managerFactory != null) {
		managerFactory.mouseMove(eventType);
	}
}
</code>
				</pre>
			</article>
		</div>
	</div>
</body>
</html>