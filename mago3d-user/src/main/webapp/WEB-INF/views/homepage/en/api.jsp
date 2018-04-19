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
<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
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
				<a href="/homepage/api.do">mago3D.JS</a>
			</h3>
			<div class="search">
				<input id="search" type="text" class="form-control input-sm" placeholder="Search Documentations">
			</div>
			<ul class="list">
				<li class="item"><span class="api_title"> <a class="api" href="#changeMagoStateAPI">changeMagoStateAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeBoundingBoxAPI">changeBoundingBoxAPI</a>
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
			</ul>
		</div>
		<div class="main" id="content">
			<div class="header">
				<h2>mago3D.JS V1.0.0</h2>
				<img src="/images/${lang}/homepage/AC.png" style="margin-bottom: 10px;" />
			</div>
			<article class="readme">
				<img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg"> <img src="https://img.shields.io/badge/language-English-orange.svg" /> <img src="https://img.shields.io/badge/language-Korean-blue.svg" />
				<p><b>Open source JavaScript library for 3D multi-block visualization</b></p>
				<p>It is a next generation 3D GIS platform that integrates and visualizes AEC (Architecture, Engineering, Construction) area and traditional 3D spatial information (3D GIS). Integrate AEC and 3D GIS in a web browser, indoors, outdoors, indistinguishable. You can browse and collaborate on large-scale BIM (Building Information Modeling), JT (Jupiter Tessellation), and 3D GIS files without installing any program on the web browser.</p>
				<h4>Development Environment</h4>
				<div class="list_wrap">
					<p><mark>java8, eclipse neon, node, apache, Jasmine, Jsdoc, Gulp, eslint, JQuery</mark>
				</div>
				<h4>Getting Started</h4>
				<div class="list_wrap">
					<ul class="readme_list">
						<li><b style="color: #1E90FF;">mago3DJS Install</b>
							<ul class="sub_list">
								<li><a href="https://github.com/Gaia3D/mago3djs" style="display: inline;"><b>github</b></a>It accepts mago3DJS from.</li>
								<li>Installation path C:/git/repository/mago3djs</li>
							</ul>
						</li>
					</ul>
					<ul class="readme_list">
						<li><b style="color: #1E90FF;">node Setup</b>
							<ul class="sub_list">
								<li>npm install</li>
								<li>npm install -g gulp</li>
							</ul>
						</li>
					</ul>
					<ul class="readme_list">
						<li><b style="color: #1E90FF;">Running the server</b>
							<ul class="sub_list">
								<li>Running a local server:  C:\git\repository\mago3djs> node server.js</li>
								<li>Running a public server:  C:\git\repository\mago3djs> node server.js --public true</li>
							</ul>
						</li>
					</ul>
					<ul class="readme_list">
						<li><b style="color: #1E90FF;">Data folder link</b>
							<ul class="sub_list">
								<li>Create Data Folder: mklink /d "C:\git\repository\mago3djs\data" "C:\data"</li>
								<li>Delete data folder: C:\git\repository\mago3djs>rmdir data</li>
							</ul>
						</li>
					</ul>
				</div>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeMagoStateAPI">changeMagoStateAPI</span></h2>
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
							<td>true: Activation, false: Disabled</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;mago3D
	&lt;input type="radio" id="magoEnable" name="magoState" value="0" checked="checked" onclick="changeMagoState(true);" /&gt;
	&lt;label for="magoEnable"&gt; Activation &lt;/label&gt;
	&lt;input type="radio" id="magoDisable" name="magoState" value="1"  onclick="changeMagoState(false);" /&gt;
	&lt;label for="magoDisable"&gt; Disabled &lt;/label&gt;
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
				<h2><span id="changeBoundingBoxAPI">changeBoundingBoxAPI</span></h2>
				<p>ChangeBoundingBoxAPI BoundingBox is displayed and hidden by changing the activation state value.</p>
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
function changeBoundingBox(isShow) {
	changeBoundingBoxAPI(isShow);
}
</code>
			</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeShadowAPI">changeShadowAPI</span></h2>
				<p>ChangeShadowAPI Activation Shows and hides the Structure, Outfitting shadow of a block by changing the value of the state</p>
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
				<br> <b>JavaScript</b>
				<pre>
<code>
function changeShadow(isShow) {
	changeShadowAPI(isShow);
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeFrustumFarDistanceAPI">changeFrustumFarDistanceAPI</span></h2>
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
&lt;input type="text" id="frustumFarDistance" name="frustumFarDistance" placeholder="Meter(m)" /&gt;
&lt;button type="button" id="changeFrustumFarDistanceAPI" class="btn btn-default btn-sm">apply&lt;/button&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>
$("#changeFrustumFarDistanceAPI").click(function() {
	if(!changeFrustumFarDistanceCheck()) return false;
	changeFrustumFarDistanceAPI($("#frustumFarDistance").val());
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="searchDataAPI">searchDataAPI</span></h2>
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
	&lt;span&gt;Data Key&lt;/span&gt;
	&lt;input type="text" id="search_data_key" name="search_data_key"/&gt;
	&lt;button type="button" id="searchData">search&lt;/button&gt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>
$("#searchData").click(function() {
	if ($.trim($("#search_data_key").val()) === ""){
		alert("Please enter the Data Key.");
		$("#search_data_key").focus();
		return false;
	}
	searchDataAPI($("#search_data_key").val());
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeColorAPI">changeColorAPI</span></h2>
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
	&lt;input type="text" id="objectIds" name="objectIds" placeholder=", Enter segment"/&gt;
	&lt;label for="colorBlock"&gt;Color&lt;/label/&gt;
	&lt;select id="colorBlock" name="colorBlock"/&gt;
		&lt;option value=""&gt; None &lt;/option/&gt;
		&lt;option value="255,0,0"&gt; Red &lt;/option/&gt;
		&lt;option value="255,255,0"&gt; Yellow &lt;/option/&gt;
		&lt;option value="0,255,0"&gt; Green &lt;/option/&gt;
		&lt;option value="0,0,255"&gt; Blue &lt;/option/&gt;
		&lt;option value="255,0,255"&gt; Pink &lt;/option/&gt;
		&lt;option value="0,0,0"&gt; Black &lt;/option/&gt;
	&lt;/select&gt;
	&lt;button type="button" id="changeColorAPI" class="btn btn-default btn-sm">change&lt;/button&gt;
&lt;div/&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>
$("#changeColorAPI").click(function(e) {
	if(!changeColorCheck(e)) return false;
	changeColorAPI($("#objectIds").val(), $("#colorBlock").val());
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeLocationAndRotationAPI">changeLocationAndRotationAPI</span></h2>
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
			&lt;input type="text" id="move_data_key" name="move_data_key"/&gt;
		&lt;/span&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;span&gt;
			&lt;label for="move_latitude"&gt;Latitude&lt;/label&gt;
			&lt;input type="text" id="move_latitude" name="move_latitude"/&gt;
		&lt;/span&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;span&gt;
			&lt;label for="move_longitude"&gt;Longitude&lt;/label&gt;
			&lt;input type="text" id="move_longitude" name="move_longitude"/&gt;
		&lt;/span&gt;
	&lt;/div&gt;	
	.
	.
	.
	&lt;div&gt;
		&lt;span&gt;
			&lt;label for="move_roll"&gt;ROLL&lt;/label&gt;
			&lt;input type="text" id="move_roll" name="move_roll"/&gt;
			&lt;button type="button" id="changeLocationAndRotationAPI">Transform&lt;/button&gt;
		&lt;/span&gt;
	&lt;/div&gt;		
&lt;/div&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>
$("#changeLocationAndRotationAPI").click(function() {
	changeLocationAndRotationAPI(	$("#move_data_key").val(), $("#move_latitude").val(), $("#move_longitude").val(), 
							$("#move_height").val(), $("#move_heading").val(), $("#move_pitch").val(), $("#move_roll").val());
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeMouseMoveAPI">changeMouseMoveAPI</span></h2>
				<p>
You can change the mode of movement when you click the mouse. If mouseMoveMode is 0, it means that the entire movement, 1 means move the object, 2 means the movement.</p>
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
							<td>mouseMoveMode 0 = All, 1 = object, 2 = None</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;
	&lt;span&gt;Selecting And Moving&lt;/span&gt;
	&lt;input type="radio" id="mouseNoneMove" name="mouseMoveMode" value="2" onclick="changeMouseMove('2');"/&gt;
	&lt;label for="mouseNoneMove"&gt; None &lt;/label&gt;
	&lt;div&gt;
		&lt;input type="radio" id="mouseAllMove" name="mouseBlockMove" value="0" onclick="changeMouseMove('0')"/&gt;
		&lt;label for="mouseAllMove"&gt;All&lt;/label&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;input type="radio" id="mouseObjectMove" name="mouseBlockMove" value="1" onclick="changeMouseMove('1')"/&gt;
		&lt;label for="mouseObjectMove"&gt;Object&lt;/label&gt;
	&lt;/div&gt;		
&lt;/div&gt;	
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>
function changeMouseMove(mouseMoveMode) {
	changeMouseMoveAPI(mouseMoveMode);
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeInsertIssueModeAPI">changeInsertIssueModeAPI</span></h2>
				<p>
					ChangeInsertIssueModeAPI is an API to enable artifacts. The parameter flag in this API is Boolean type, and if true, the issue mode is activated
					If false, the method is disabled. If you click on the object for which you want to register an issue, the issue registration callback function is called according to the database operation policy managing the callback function
					The issue registration window appears. If you save the contents in the issue registration window, it will be registered in the database. In addition, the issue callback function can be customized by the user.
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
							<td>flag</td>
							<td>true = enable, false = disable</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;button id="issueEnable"&gt;Issue insert&lt;/button&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code>
var insertIssueFlag = false;
$("#issueEnable").click(function() {
	if(insertIssueFlag) {
		insertIssueFlag = false;
		$("#issueEnable").removeClass("on");
	} else {
		insertIssueFlag = true;
		$("#issueEnable").addClass("on");
	}
	changeInsertIssueModeAPI(insertIssueFlag);
});
</code>
			</pre>
			<br><b>Callback function called from mago3DJS</b>
			<pre>
<code class=javascript>
function showInsertIssueLayer(data_name, data_key, latitude, longitude, height) {
	if(insertIssueFlag) {
		if($("#inputIssueLayer").css("display") == "none") {
			$("#inputIssueLayer").show();
			
			$("#data_key").val(data_name);
			$("#latitude").val(latitude);
			$("#longitude").val(longitude);
			$("#height").val(height);
			
			// Save current coordinates
			$("#now_latitude").val(latitude);
			$("#now_longitude").val(longitude);
		}
	}
}
</code>
			</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeObjectInfoViewModeAPI">changeObjectInfoViewModeAPI</span></h2>
				<p>
					ChangeObjectInfoViewModeAPI is an API that enables the display of Object information. The parameter flag in this API is Boolean type,
					Mode is enabled and disabled if it is false. If you click on an object for which you want to know the information while it is activated, the callback function will manage the callback function.
					The object information is called through Jquery Plugin Toast. In addition, the information display callback function can be customized by the user.
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
							<td>flag</td>
							<td>true = enable, false = disable</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>html</b>
				<pre>
<code>
&lt;div&gt;
	&lt;button id="objectInfoEnable"&gt;Object Information&lt;/button&gt;	
&lt;/div&gt;
</code>			
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code>
var objectInfoViewFlag = false;
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
				<br><b>Callback function called from mago3DJS</b>
				<pre>
<code>
function showSelectedObject(projectId, blockId, objectId, latitude, longitude, height, heading, pitch, roll){
	if(objectInfoViewFlag) {
		$("#move_data_key").val(projectId + "_" + blockId);
		$("#move_latitude").val(latitude);
		$("#move_longitude").val(longitude);
		$("#move_height").val(height);
		$("#move_heading").val(heading);
		$("#move_pitch").val(pitch);
		$("#move_roll").val(roll);
		
		$.toast({
		    heading: 'Click Object Info',
		    text: [
		        'projectId : ' + projectId, 
		        'blockId : ' + blockId, 
		        'objectId : ' + objectId,
		        'latitude : ' + latitude,
		        'longitude : ' + longitude,
		        'height : ' + height,
		        'heading : ' + heading,
		        'pitch : ' + pitch,
		        'roll : ' + roll
		    ],
			//bgColor : 'blue',
			hideAfter: 5000,
			icon: 'info'
		});
		
		// save
		$("#now_latitude").val(latitude);
		$("#now_longitude").val(longitude);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeListIssueViewModeAPI">changeListIssueViewModeAPI</span></h2>
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
<code class="html">
&lt;button id="issuesEnable"&gt;Issues Display&lt;/button&gt;
&lt;input type="hidden" id="now_latitude" name="now_latitude" value="&#36;{now_latitude}" /&gt;
&lt;input type="hidden" id="now_longitude" name="now_longitude" value="&#36;{now_longitude}"  /&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>
$("#issuesEnable").click(function() {
	if(listIssueFlag) {
		listIssueFlag = false;
		$("#issuesEnable").removeClass("on");
	} else {
		listIssueFlag = true;
		$("#issuesEnable").addClass("on");
		
		// Display up to 100 issue lists belonging to the nearest data group with latitude and logitude of the current position
		var now_latitude = $("#now_latitude").val();
		var now_longitude = $("#now_longitude").val();
		var info = "latitude=" + now_latitude + "&longitude=" + now_longitude;		
		$.ajax({
			url: "/issue/ajax-list-issue-by-geo.do",
			type: "GET",
			data: info,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var issueList = msg.issueList;
					if(issueList != null && issueList.length > 0) {
						for(i=0; i&lt;issueList.length; i++ ) {
							var issue = issueList[i];
							drawInsertIssueImageAPI(0, issue.issue_id, issue.issue_type, issue.data_key, issue.latitude, issue.longitude, issue.height);
						}
					}
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error:function(request,status,error){
		        //alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	changeListIssueViewModeAPI(listIssueFlag);
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="drawInsertIssueImageAPI">drawInsertIssueImageAPI</span></h2>
				<p>Pin image is drawn. If drawType is 0, DB, 1, then issue issue</p>
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
				<br> <b>JavaScript</b>
				<pre>
<code class="javascript">
drawInsertIssueImageAPI(0, issue.issue_id, issue.issue_type, issue.data_key, issue.latitude, issue.longitude, issue.height);
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeInsertIssueStateAPI">changeInsertIssueStateAPI</span></h2>
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
				<b>JavaScript</b>
				<pre>
<code class="javascript">
changeInsertIssueStateAPI(0);
</code>
				</pre>
			</article>
		</div>
	</div>
</body>
</html>