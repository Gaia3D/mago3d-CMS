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
<link rel="stylesheet" href="/externlib/highlight/styles/agate.css" />
<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
<link rel="stylesheet" href="/css/${lang}/font/font.css" />
<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/analytics.js"></script>
<script type="text/javascript" src="/externlib/highlight/highlight.js"></script>
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
				<li class="item"><span class="api_title"><a class="api" href="#changeMagoStateAPI">changeMagoStateAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeLabelAPI">changeLabelAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeOriginAPI">changeOriginAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeBoundingBoxAPI">changeBoundingBoxAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changePropertyRenderingAPI">changePropertyRenderingAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeShadowAPI">changeShadowAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeColorAPI">changeColorAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeLocationAndRotationAPI">changeLocationAndRotationAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeObjectMoveAPI">changeObjectMoveAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#saveObjectMoveAPI">saveObjectMoveAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#deleteAllObjectMoveAPI">deleteAllObjectMoveAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#deleteAllChangeColorAPI">deleteAllChangeColorAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeInsertIssueModeAPI">changeInsertIssueModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeObjectInfoViewModeAPI">changeObjectInfoViewModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeOcclusionCullingAPI">changeOcclusionCullingAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeFPVModeAPI">changeFPVModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeNearGeoIssueListViewModeAPI">changeNearGeoIssueListViewModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeInsertIssueStateAPI">changeInsertIssueStateAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeLodAPI">changeLodAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeLightingAPI">changeLightingAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#changeSsaoRadiusAPI">changeSsaoRadiusAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#clearAllDataAPI">clearAllDataAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#drawInsertIssueImageAPI">drawInsertIssueImageAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#gotoProjectAPI">gotoProjectAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#gotoIssueAPI">gotoIssueAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#mouseMoveAPI">mouseMoveAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#searchDataAPI">searchDataAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#isDataExistAPI">isDataExistAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#getDataAPI">getDataAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#getDataInfoByDataKeyAPI">getDataInfoByDataKeyAPI</a>
				</span></li>
				<li class="item"><span class="api_title"><a href="#drawAppendDataAPI">drawAppendDataAPI</a>
				</span></li>
			</ul>
		</div>
		<div class="main" id="content">
		<article class="api_description" style="margin-top: 50px;">
				<img src="/images/${lang}/homepage/logo_mago3d.png" style="margin-bottom: 50px; margin-left: 120px;" />
				<h2>mago3D.JS V1.0.5</h2>
				<article class="readme">
				<img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg"> <img src="https://img.shields.io/badge/language-English-orange.svg" /> <img src="https://img.shields.io/badge/language-Korean-blue.svg" />
				<p><b>Open source JavaScript library for 3D multi-block visualization</b></p>
				<p>It is a next generation 3D GIS platform that integrates and visualizes AEC (Architecture, Engineering, Construction) area and traditional 3D spatial information (3D GIS). Integrate AEC and 3D GIS in a web browser, indoors, outdoors, indistinguishable. You can browse and collaborate on large-scale BIM (Building Information Modeling), JT (Jupiter Tessellation), and 3D GIS files without installing any program on the web browser.</p>
				<h4>Development Environment</h4>
				<div class="list_wrap">
					<p>java8, eclipse neon, node, apache, Jasmine, Jsdoc, Gulp, eslint, JQuery</p>
				</div>
				<h4>Getting Started</h4>
				<div class="list_wrap">
					<ul class="readme_list">
						<li><b style="color: #1E90FF;">mago3DJS Install</b>
							<ul class="sub_list">
								<li><a href="https://github.com/Gaia3D/mago3djs" style="display: inline;"><b>github</b> </a>It accepts mago3DJS from.</li>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>isShow</td>
							<td>true: Enabled, false: Disabled</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;MagoState&lt;/h3&gt;
	&lt;input type="radio" id="magoEnable" name="magoState" value="0" checked="checked" onclick="changeMagoState(true);" /&gt;
	&lt;label for="magoEnable"&gt; Enabled &lt;/label&gt;
	&lt;input type="radio" id="magoDisable" name="magoState" value="1"  onclick="changeMagoState(false);" /&gt;
	&lt;label for="magoDisable"&gt; Disabled &lt;/label&gt;
&lt;/div&gt;
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>function changeMagoState(isShow) {
	$("input:radio[name='magoState']:radio[value='" + isShow + "']").prop("checked", true);
	changeMagoState(managerFactory, isShow);
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeLabelAPI">changeLabelAPI</span></h2>
				<p>changeLabelAPI Enables or disables the label by changing the activation status value.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D mago3D starting point</td>
						</tr>
						<tr>
							<td>isShow</td>
							<td>true: Enabled, false: Disabled</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;Label&lt;/h3&gt;
	&lt;input type="radio" id="showLabel" name="labelInfo" value="true" onclick="changeLabel(true);" /&gt;
	&lt;label for="showLabel"&gt; Display &lt;/label&gt;
	&lt;input type="radio" id="hideLabel" name="labelInfo" value="false"  onclick="changeLabel(false);" /&gt;
	&lt;label for="hideLabel"&gt; Hide &lt;/label&gt;
&lt;/div&gt;
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>function changeLabel(isShow) {
		$("input:radio[name='labelInfo']:radio[value='" + isShow + "']").prop("checked", true);
		changeLabelAPI(managerFactory, isShow);
	}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeOriginAPI">changeOriginAPI</span></h2>
				<p>Origin is displayed and hidden by changing the value of the changeOriginAPI activation state.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>isShow</td>
							<td>true: Enabled, false: Disabled</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;Origin&lt;/h3&gt;
	&lt;input type="radio" id="showOrigin" name="origin" value="true" onclick="changeOrigin(true);" /&gt;
	&lt;label for="showOrigin"&gt; Display &lt;/label&gt;
	&lt;input type="radio" id="hideOrigin" name="origin" value="false"  onclick="changeOrigin(false);" /&gt;
	&lt;label for="hideOrigin"&gt; Hide &lt;/label&gt;
&lt;/div&gt;
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>function changeOrigin(isShow) {
        $("input:radio[name='origin']:radio[value='" + isShow + "']").prop("checked", true);
        changeOriginAPI(managerFactory, isShow);
	}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeBoundingBoxAPI">changeBoundingBoxAPI</span></h2>
				<p>changeBoundingBoxAPI BoundingBox is displayed and hidden by changing the activation status value.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>isShow</td>
							<td>true: Enabled, false: Disabled</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;BoundingBox&lt;/h3&gt;
	&lt;input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBox(true);" /&gt;
	&lt;label for="showBoundingBox"&gt; Display &lt;/label&gt;
	&lt;input type="radio" id="hideBoundingBox" name="boundingBox" value="false"  onclick="changeBoundingBox(false);" /&gt;
	&lt;label for="hideBoundingBox"&gt; Hide &lt;/label&gt;
&lt;/div&gt;
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code class="JavaScript">function changeBoundingBox(isShow) {
	$("input:radio[name='boundingBox']:radio[value='" + isShow + "']").prop("checked", true);
	changeBoundingBoxAPI(managerFactory, isShow);
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changePropertyRenderingAPI">changePropertyRenderingAPI</span></h2>
				<p>API to set visibility by attribute value.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>isShow</td>
							<td>true = Display, false = Hide</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>Project Id</td>
						</tr>
						<tr>
							<td>property</td>
							<td>Property</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;Property visualization&lt;/h3&gt;
	&lt;ul class="apiLocal"&gt;
		&lt;li&gt;
			&lt;input type="radio" id="showPropertyRendering" name="propertyRendering" value="true" /&gt;
			&lt;label for="showLabel"&gt; Display &lt;/label&gt;
			&lt;input type="radio" id="hidePropertyRendering" name="propertyRendering" value="false" /&gt;
			&lt;label for="hideLabel"&gt; Hide &lt;/label&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="propertyRenderingProjectId"&gt;Projecet &lt;/label&gt;
			&lt;select id="propertyRenderingProjectId" name="propertyRenderingProjectId" class="select"&gt;
				&lt;option value="data.json"&gt;...&lt;/option&gt;
			&lt;/select&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="propertyRenderingWord"&gt;Property &lt;/label&gt;
			&lt;input type="text" id="propertyRenderingWord" name="propertyRenderingWord" size="23" placeholder="isMain=true" /&gt;
			&lt;button type="button" id="changePropertyRendering" class="btn"&gt;change&lt;/button&gt; 
		&lt;/li&gt;
	&lt;/ul&gt;
&lt;/div&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">$("#changePropertyRendering").click(function(e) {
	var isShow = $(':radio[name="propertyRendering"]:checked').val();
	if(isShow === undefined){
		alert("Select Show / Hide.");
		return false;
	}
	if ($.trim($("#propertyRenderingWord").val()) === ""){
		alert("Please enter attribute value.");
		$("#propertyRenderingWord").focus();
		return false;
	}
	changePropertyRenderingAPI(managerFactory, isShow, $("#propertyRenderingProjectId").val(), $("#propertyRenderingWord").val());
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeShadowAPI">changeShadowAPI</span></h2>
				<p>Enable or disable shadow display</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>isShow</td>
							<td>true: Enabled, false: Disabled</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;Shadow settings&lt;/h3&gt;
	&lt;input type="radio" id="showShadow" name="shadow" value="true" onclick="changeShadow(true);" /&gt;
	&lt;label for="showShadow"&gt; Display &lt;/label&gt;
	&lt;input type="radio" id="hideShadow" name="shadow" value="false"  onclick="changeShadow(false);" /&gt;
	&lt;label for="hideShadow"&gt; Hide &lt;/label&gt;
&lt;/div&gt;
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>
function changeShadow(isShow) {
	$("input:radio[name='shadow']:radio[value='" + isShow + "']").prop("checked", true);
	changeShadowAPI(managerFactory, isShow);
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeColorAPI">changeColorAPI</span></h2>
				<p>
					An API that changes the color of objects or data objects that you want on a project-by-project basis.
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>Project Id</td>
						</tr>
						<tr>
							<td>dataKey</td>
							<td>Data unique key</td>
						</tr>
						<tr>
							<td>objectIds</td>
							<td>object id. In a plurality of cases,</td>
						</tr>
						<tr>
							<td>property</td>
							<td>Property Value Example)isMain=true</td>
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
<code>&lt;div&gt;
	&lt;h3&gt;Change color&lt;/h3&gt;
	&lt;ul class="apiLoca"&gt;
		&lt;li&gt;
			&lt;label for="colorProjectId"&gt;Project &lt;/label&gt;
			&lt;select id="colorProjectId" name="colorProjectId" class="select"&gt;
				&lt;option value="data.json"&gt;...&lt;/option&gt;
			&lt;/select&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="colorDataKey"&gt;Data Key&lt;/label&gt;
			&lt;input type="text" id="colorDataKey" name="colorDataKey" size="30" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="colorObjectIds"&gt;Object Id&lt;/label&gt;
			&lt;input type="text" id="colorObjectIds" name="colorObjectIds" placeholder="   , division" size="30" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="colorProperty"&gt;Property&lt;/label&gt;
			&lt;input type="text" id="colorProperty" name="colorProperty" size="30" placeholder="isMain=true" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="updateColor"&gt;����&lt;/label&gt;
			&lt;select id="updateColor" name="updateColor" class="select"&gt;
				&lt;option value="255,0,0"&gt; Red &lt;/option&gt;
				&lt;option value="255,255,0"&gt; Yellow &lt;/option&gt;
				&lt;option value="0,255,0"&gt; Green &lt;/option&gt;
				&lt;option value="0,0,255"&gt; Blue &lt;/option&gt;
				&lt;option value="255,0,255"&gt; Pink &lt;/option&gt;
				&lt;option value="0,0,0"&gt; Black &lt;/option&gt;
			&lt;/select&gt;
			&lt;button type="button" id="changeColor" class="btn"&gt;change&lt;/button&gt; 
		&lt;/li&gt;
	&lt;/ul&gt;
&lt;/div&gt;
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#changeColor").click(function(e) {
	if ($.trim($("#colorDataKey").val()) === ""){
		alert("Please enter your Data Key.");
		$("#colorDataKey").focus();
		return false;
	}
		
	var objectIds = null;
	var colorObjectIds = $("#colorObjectIds").val();
	if(colorObjectIds !== null && colorObjectIds !=="") objectIds = colorObjectIds.split(",");
	changeColorAPI(managerFactory, $("#colorProjectId").val(), $("#colorDataKey").val(), objectIds, $("#colorProperty").val(), $("#updateColor").val());
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>Project Id</td>
						</tr>
						<tr>
							<td>dataKey</td>
							<td>Data unique key</td>
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
<code>&lt;div>
	&lt;h3&gt;Location and Rotation&lt;/h3&gt;
	&lt;ul class="apiLoca"&gt;
		&lt;li&gt;
			&lt;label for="moveProjectId"&gt;Project &lt;/label&gt;
			&lt;select id="moveProjectId" name="moveProjectId" class="select"&gt;
				&lt;option value="data.json"&gt;...&lt;/option&gt;
			&lt;/select&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="moveDataKey"&gt;Data Key&lt;/label&gt;
			&lt;input type="text" id="moveDataKey" name="moveDataKey" size="25" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="moveLatitude"&gt;latitude &lt;/label&gt;
			&lt;input type="text" id="moveLatitude" name="moveLatitude" size="25"/&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="moveLongitude"&gt;longitude &lt;/label&gt;
			&lt;input type="text" id="moveLongitude" name="moveLongitude" size="25"/&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="moveHeight"&gt;height &lt;/label&gt;
			&lt;input type="text" id="moveHeight" name="moveHeight" size="25" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="moveHeading"&gt;HEADING &lt;/label&gt;
			&lt;input type="text" id="moveHeading" name="moveHeading" size="25" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="movePitch"&gt;PITCH &lt;/label&gt;
			&lt;input type="text" id="movePitch" name="movePitch" size="25" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="moveRoll"&gt;ROLL &lt;/label&gt;
			&lt;input type="text" id="moveRoll" name="moveRoll" size="18" /&gt;
			&lt;button type="button" id="changeLocationAndRotation" class="btn"&gt;��ȯ&lt;/button&gt; 
		&lt;/li&gt;
	&lt;/ul&gt;
&lt;/div&gt;
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#changeLocationAndRotation").click(function() {
	if(!changeLocationAndRotationCheck()) return false;
	changeLocationAndRotationAPI(managerFactory, $("#moveProjectId").val(), $("#moveDataKey").val(), $("#moveLatitude").val(), 
					       	     $("#moveLongitude").val(), $("#moveHeight").val(), $("#moveHeading").val(), 
					    	     $("#movePitch").val(), $("#moveRoll").val());
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeObjectMoveAPI">changeObjectMoveAPI</span></h2>
				<p>Change mouse click object movement destination</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>objectMoveMode</td>
							<td>0 = All, 1 = object, 2 = None</td> 
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;Selecting And Moving&lt;/h3&gt;
	&lt;input type="radio" id="objectNoneMove" name="objectMoveMode" value="2" onclick="changeObjectMove('2');"/&gt;
	&lt;label for="objectNoneMove"&gt; None &lt;/label&gt;
	&lt;input type="radio" id="mouseAllMove" name="objectMoveMode" value="0" onclick="changeObjectMove('0');"/&gt;
	&lt;label for="objectAllMove"&gt; ALL &lt;/label&gt;
	&lt;input type="radio" id="objectMove" name="objectMoveMode" value="1" onclick="changeObjectMove('1');"/&gt;
	&lt;label for="objectMove"&gt; Object &lt;/label&gt;
&lt;/div&gt;	
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>function changeObjectMove(objectMoveMode) {
	$("input:radio[name='objectMoveMode']:radio[value='" + objectMoveMode + "']").prop("checked", true);
	changeObjectMoveAPI(managerFactory, objectMoveMode);
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="saveObjectMoveAPI">saveObjectMoveAPI</span></h2>
				<p>Save all object mouse move history as Cache.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>objectMoveMode</td>
							<td>0 = All, 1 = object, 2 = None</td> 
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;button type="button" id="saveObjectMoveButton" class="btn"&gt;Save&lt;/button&gt;	
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#saveObjectMoveButton").click(function () {
	alert("�غ��� �Դϴ�.");
	var objectMoveMode = $(':radio[name="objectMoveMode"]:checked').val();
	if(objectMoveMode === "2") {
		alert("Can not be saved in None mode.");
		return;
	}
	saveObjectMoveAPI(managerFactory, objectMoveMode);
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="deleteAllObjectMoveAPI">deleteAllObjectMoveAPI</span></h2>
				<p>��� ��ü ���콺 �̵� �̷��� Cache�� �輼�մϴ�.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D ���� �κ�</td>
						</tr>
						<tr>
							<td>objectMoveMode</td>
							<td>0 = All, 1 = object, 2 = None</td> 
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;button type="button" id="deleteAllObjectMoveButton" class="btn"&gt;��ü ����&lt;/button&gt;
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#deleteAllObjectMoveButton").click(function () {
	var objectMoveMode = $(':radio[name="objectMoveMode"]:checked').val();
	if(confirm("���� �Ͻðڽ��ϱ�?")) {
		deleteAllObjectMoveAPI(managerFactory, objectMoveMode);
	}
});
</code>
				</pre>
			</article>
			<hr>		
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="deleteAllChangeColorAPI">deleteAllChangeColorAPI</span></h2>
				<p>������ ���� �̷��� ��ü �����մϴ�.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D ���� �κ�</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;button type="button" id="deleteAllChangeColor" class="btn"&gt;��ü ����&lt;/button&gt;
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#deleteAllChangeColor").click(function () {
	if(confirm("���� �Ͻðڽ��ϱ�?")) {
		deleteAllChangeColorAPI(managerFactory);
	}
});
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>flag</td>
							<td>true = Enable, false = disable</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;button type="button" id="insertIssueEnableButton" class="btn"&gt;Please select object after clicking.&lt;/button&gt; 
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code>$("#insertIssueEnableButton").click(function() {
	if(insertIssueEnable) {
		$("#insertIssueEnableButton").removeClass("on");
		$("#insertIssueEnableButton").text("Please select object after clicking.");
		insertIssueEnable = false;
	} else {
		$("#insertIssueEnableButton").addClass("on");
		$("#insertIssueEnableButton").text("Status of issue registration activation");
		insertIssueEnable = true;
	}
	changeInsertIssueModeAPI(managerFactory, insertIssueEnable);
});
</code>
				</pre>
				<br><b>Callback function called from mago3DJS</b>
			<pre>
<code class=javascript>	function showInsertIssueLayer(projectId, dataKey, objectKey, latitude, longitude, height) {
		if(insertIssueEnable) {
		    $("#issueProjectId").val(projectId);
			$("#data_key").val(dataKey);
			$("#object_key").val(objectKey);
			$("#latitude").val(latitude);
			$("#longitude").val(longitude);
			$("#height").val(height);
			
			// Save current coordinates
			saveCurrentLocation(latitude, longitude);
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>flag</td>
							<td>true = Enable, false = disable</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;Object Information&lt;/h3&gt;
	&lt;input type="radio" id="showObjectInfo" name="objectInfo" value="true" onclick="changeObjectInfoViewMode(true);" /&gt;
	&lt;label for="showObjectInfo"&gt; Display &lt;/label&gt;
	&lt;input type="radio" id="hideObjectInfo" name="objectInfo" value="false" onclick="changeObjectInfoViewMode(false);"/&gt;
	&lt;label for="hideObjectInfo"&gt; Hide &lt;/label&gt;
&lt;/div&gt;
</code>			
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code>function changeObjectInfoViewMode(isShow) {
	$("input:radio[name='objectInfo']:radio[value='" + isShow + "']").prop("checked", true);
	changeObjectInfoViewModeAPI(managerFactory, isShow);
}
</code>
				</pre>
				<br><b>Callback function called from mago3DJS</b>
				<pre>
<code>function showSelectedObject(projectId, dataKey, objectId, latitude, longitude, height, heading, pitch, roll) {
		var objectInfoViewFlag = $(':radio[name="objectInfo"]:checked').val();
		if(objectInfoViewFlag) {
		    $("#moveProjectId").val(projectId);
			$("#moveDataKey").val(dataKey);
			$("#moveLatitude").val(latitude);
			$("#moveLongitude").val(longitude);
			$("#moveHeight").val(height);
			$("#moveHeading").val(heading);
			$("#movePitch").val(pitch);
			$("#moveRoll").val(roll);
			
			$.toast({
			    heading: 'Click Object Info',
			    text: [
					'ProjectId : ' + projectId,
			        'dataKey : ' + dataKey,
			        'objectId : ' + objectId,
			        'latitude : ' + latitude,
			        'longitude : ' + longitude,
			        'height : ' + height,
			        'heading : ' + heading,
			        'pitch : ' + pitch,
			        'roll : ' + roll
			    ],
				bgColor : '#393946',
				hideAfter: 5000,
				icon: 'info',
				position : 'bottom-right'
			});
			
			// occlusion culling
			$("#occlusion_culling_data_key").val(dataKey);
			// ���� ��ǥ�� ����
			saveCurrentLocation(latitude, longitude);
	}
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeOcclusionCullingAPI">changeOcclusionCullingAPI</span></h2>
				<p>Object Occlusion culling</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>flag</td>
							<td>true: Enabled, false: Disabled</td>
						</tr>
						<tr>
							<td>dataKey</td>
							<td>Data unique key</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;Object Occlusion Culling&lt;/h3&gt;
	&lt;div&gt;
		&lt;div&gt;Whether or not to use&lt;/div&gt;
		&lt;input type="radio" id="useOcclusionCulling" name="occlusionCulling" value="true" /&gt;
		&lt;label for="useOccusionCulling"&gt; use &lt;/label&gt;
		&lt;input type="radio" id="unusedOcclusionCulling" name="occlusionCulling" value="false" /&gt;
		&lt;label for="unusedOcclusionCulling"&gt; unused &lt;/label&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;div&gt;Data Key&lt;/div&gt;
		&lt;input type="text" id="occlusion_culling_data_key" name="occlusion_culling_data_key"/&gt;
		&lt;button type="button" id="changeOcclusionCullingButton" class="btn"&gt;change&lt;/button&gt;
	&lt;/div&gt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#changeOcclusionCullingButton").click(function () {
	changeOcclusionCullingAPI(managerFactory, ($(':radio[name="occlusionCulling"]:checked').val() === "true"), $("#occlusion_culling_data_key").val());		
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeFPVModeAPI">changeFPVModeAPI</span></h2>
				<p>This is an API that changes the camera to first person or third person mode.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>flag</td>
							<td>true: Enabled, false: Disabled</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
			    <b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;View Mode&lt;/h3&gt;
	&lt;input type="radio" id="mode3PV" name="viewMode" value ="false" onclick="changeViewMode(false);"/&gt;
	&lt;label for="mode3PV"&gt; Third person mode &lt;/label&gt;
	&lt;input type="radio" id="mode1PV" name="viewMode" value ="true" onclick="changeViewMode(true);"/&gt;
	&lt;label for="mode1PV"&gt; First person mode &lt;/label&gt;
&lt;/div&gt;
</code>
				</pre>
				<br> <b>JavaScript</b>
				<pre>
<code class="javascript">function changeViewMode(isFPVMode) {
	$("input:radio[name='viewMode']:radio[value='" + isFPVMode + "']").prop("checked", true);
	changeFPVModeAPI(managerFactory, isFPVMode);
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeNearGeoIssueListViewModeAPI">changeNearGeoIssueListViewModeAPI</span></h2>
				<p>Ȱ��ȭ�� ���� ��ġ ��ó issue�� �����ִ� API�Դϴ�.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D ���� �κ�</td>
						</tr>
						<tr>
							<td>flag</td>
							<td>true = Ȱ��ȭ, false = ��Ȱ��ȭ</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;���� ��ġ ��ó Issue List(100��)&lt;/h3&gt;
	&lt;input type="radio" id="showNearGeoIssueList" name="nearGeoIssueList" value="true" onclick="changeNearGeoIssueList(true);" /&gt;
	&lt;label for="showNearGeoIssueList"&gt; ǥ�� &lt;/label&gt;
	&lt;input type="radio" id="hideNearGeoIssueList" name="nearGeoIssueList" value="false" onclick="changeNearGeoIssueList(false);"/&gt;
	&lt;label for="hideNearGeoIssueList"&gt; ��ǥ�� &lt;/label&gt;
&lt;/div&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">changeNearGeoIssueListViewModeAPI(managerFactory, isShow);
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeInsertIssueStateAPI">changeInsertIssueStateAPI</span></h2>
				<p>mago3DJS ������ �̽� ����� ���ؼ� ��ǥ�� ����ϰ� �־��µ� changeInsertIssueStateAPI�� �Ķ���Ϳ� 0�� �Ѱ� �ָ� ��ǥ�� �ʱ�ȭ�մϴ�.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D ���� �κ�</td>
						</tr>
						<tr>
							<td>insertIssueState</td>
							<td>�̽� ��� ��ǥ ����</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">changeInsertIssueStateAPI(managerFactory, 0);
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeLodAPI">changeLodAPI</span></h2>
				<p>LOD(Level Of Detail)������ �������ִ� API�Դϴ�.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D ���� �κ�</td>
						</tr>
						<tr>
							<td>lod0DistInMeters</td>
							<td>lod0DistInMeters</td>
						</tr>
						<tr>
							<td>lod1DistInMeters</td>
							<td>lod1DistInMeters</td>
						</tr>
						<tr>
							<td>lod2DistInMeters</td>
							<td>lod2DistInMeters</td>
						</tr>
						<tr>
							<td>lod3DistInMeters</td>
							<td>lod3DistInMeters</td>
						</tr>
						<tr>
							<td>lod4DistInMeters</td>
							<td>lod4DistInMeters</td>
						</tr>
						<tr>
							<td>lod5DistInMeters</td>
							<td>lod5DistInMeters</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;LOD&lt;/h3&gt;
	&lt;div&gt;LOD0&lt;/div&gt;
	&lt;input type="text" id="geo_lod0" name="geo_lod0" value="${policy.geo_lod0}" size="15" /&gt;&nbsp;M
	&lt;div&gt;LOD1&lt;/div&gt;
	&lt;input type="text" id="geo_lod1" name="geo_lod1" value="${policy.geo_lod0}" size="15" /&gt;&nbsp;M
	&lt;div&gt;LOD2&lt;/div&gt;
	&lt;input type="text" id="geo_lod2" name="geo_lod2" value="${policy.geo_lod0}" size="15" /&gt;&nbsp;M
	&lt;div&gt;LOD3&lt;/div&gt;
	&lt;input type="text" id="geo_lod2" name="geo_lod2" value="${policy.geo_lod0}" size="15" /&gt;&nbsp;M
	&lt;div&gt;LOD4&lt;/div&gt;
	&lt;input type="text" id="geo_lod2" name="geo_lod2" value="${policy.geo_lod0}" size="15" /&gt;&nbsp;M
	&lt;div&gt;LOD5&lt;/div&gt;
	&lt;input type="text" id="geo_lod2" name="geo_lod2" value="${policy.geo_lod0}" size="15" /&gt;&nbsp;M&nbsp;&nbsp;
	&lt;button type="button" id="changeLodButton" class="btn"&gt;����&lt;/button&gt;
&lt;/div&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">$("#changeLodButton").click(function() {
		changeLodAPI(managerFactory, $("#geo_lod0").val(), $("#geo_lod1").val(), $("#geo_lod2").val(), $("#geo_lod3").val(), $("#geo_lod4").val(), $("#geo_lod5").val());
	});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeLightingAPI">changeLightingAPI</span></h2>
				<p>������ Object�� ��⸦ �����ϴ� API�Դϴ�.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D ���� �κ�</td>
						</tr>
						<tr>
							<td>ambientReflectionCoef</td>
							<td>ambientReflectionCoef</td>
						</tr>
						<tr>
							<td>diffuseReflectionCoef</td>
							<td>diffuseReflectionCoef</td>
						</tr>
						<tr>
							<td>specularReflectionCoef</td>
							<td>specularReflectionCoef</td>
						</tr>
						<tr>
							<td>ambientColor</td>
							<td>ambientColor</td>
						</tr>
						<tr>
							<td>specularColor</td>
							<td>specularColor</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">&lt;div>
	&lt;h3&gt;Lighting&lt;/h3&gt;
	&lt;div&gt;AmbientReflectionCoeficient&lt;/div&gt;
	&lt;div id="ambient_reflection_coef"&gt;
		&lt;div id="geo_ambient_reflection_coef_view" class="ui-slider-handle"&gt;&lt;/div&gt;
		&lt;input type="hidden" id="geo_ambient_reflection_coef" name="geo_ambient_reflection_coef" value="0.5" /&gt;
	&lt;/div&gt;
	&lt;div&gt;DiffuseReflectionCoeficient&lt;/div&gt;
	&lt;div id="diffuse_reflection_coef"&gt;
		&lt;div id="geo_diffuse_reflection_coef_view" class="ui-slider-handle"&gt;&lt;/div&gt;
		&lt;input type="hidden" id="geo_diffuse_reflection_coef" name="geo_diffuse_reflection_coef" value="1" /&gt;
	&lt;/div&gt;
	&lt;div&gt;SpecularReflectionCoeficient&lt;/div&gt;
	&lt;div&gt;
		&lt;div id="specular_reflection_coef"&gt;
			&lt;div id="geo_specular_reflection_coef_view" class="ui-slider-handle"&gt;&lt;/div&gt;
			&lt;input type="hidden" id="geo_specular_reflection_coef" name="geo_specular_reflection_coef" value="1" /&gt;
		&lt;/div&gt;
		&lt;div&gt;
			&lt;button type="button" id="changeLightingButton" class="btn"&gt;����&lt;/button&gt;
		&lt;/div&gt;
	&lt;/div&gt;
&lt;/div&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">$("#changeLightingButton").click(function() {
		changeLightingAPI(managerFactory, $("#geo_ambient_reflection_coef").val(), $("#geo_diffuse_reflection_coef").val(), $("#geo_specular_reflection_coef").val(), null, null);
	});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeSsaoRadiusAPI">changeSsaoRadiusAPI</span></h2>
				<p>������ Object�� SSAO Radius�� �������ִ� API�Դϴ�.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D ���� �κ�</td>
						</tr>
						<tr>
							<td>ssaoRadius</td>
							<td>ssaoRadius</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;&lt;label for="geo_ssao_radius"&gt;SSAO Radius&lt;/label&gt;&lt;/h3&gt;
	&lt;input type="text" id="geo_ssao_radius" name="geo_ssao_radius" /&gt;
	&lt;button type="button" id="changeSsaoRadiusButton" class="btn"&gt;����&lt;/button&gt;
&lt;/div&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">$("#changeSsaoRadiusButton").click(function() {
	changeSsaoRadiusAPI(managerFactory, $("#geo_ssao_radius").val());
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="clearAllDataAPI">clearAllDataAPI</span></h2>
				<p>An API to delete and hide all data on the screen.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">function clearAllData() {
	clearAllDataAPI(managerFactory);
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="drawInsertIssueImageAPI">drawInsertIssueImageAPI</span></h2>
				<p>An API that draws Pin Image.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>drawType</td>
							<td>Draw Type</td>
						</tr>
						<tr>
							<td>issue_id</td>
							<td>Issue unique key</td>
						</tr>
						<tr>
							<td>issue_type</td>
							<td>Issue Type</td>
						</tr>
						<tr>
							<td>data_key</td>
							<td>Data unique key</td>
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
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">drawInsertIssueImageAPI(managerFactory, 1, msg.issue.issue_id, msg.issue.issue_type, 
		$("#data_key").val(), $("#latitude").val(), $("#longitude").val(), $("#height").val());
</code>
				</pre>
			</article>
			<hr>	
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="gotoProjectAPI">gotoProjectAPI</span></h2>
				<p>API to load and move the project.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>Project Id</td>
						</tr>
						<tr>
							<td>projectData</td>
							<td>Project Data</td>
						</tr>
						<tr>
							<td>projectDataFolder</td>
							<td>Project Data Folder</td>
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
							<td>duration</td>
							<td>Duration</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;ul class="shortcut"&gt;
	&lt;li onclick="gotoProject('data.json', '126.5252421', '35.425', '550', '3')"&gt;data&lt;/li&gt;
	&lt;li onclick="gotoProject('data.json', '126.5252421', '35.425', '550', '3')"&gt;data&lt;/li&gt;
	&lt;li onclick="gotoProject('data.json', '126.5252421', '35.425', '550', '3')"&gt;data&lt;/li&gt;
&lt;/ul&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">function gotoProject(projectId, longitude, latitude, height, duration) {
		var projectData = getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
		if (projectData === null || projectData === undefined) {
			$.ajax({
				url: dataInformationUrl + projectId,
				type: "GET",
				dataType: "json",
				success: function(serverData) {
					gotoProjectAPI(managerFactory, projectId, serverData, serverData.data_key, longitude, latitude, height, duration);		
				},
				error : function(request, status, error) {
					console.log("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
				}
			});
		} else {
			gotoProjectAPI(managerFactory, projectId, projectData, projectData.data_key, longitude, latitude, height, duration);	
		}
		
		// ���� ��ǥ�� ����
		saveCurrentLocation(latitude, longitude);
	}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="gotoIssueAPI">gotoIssueAPI</span></h2>
				<p>An API that loads the project and moves to that issue.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>Project Id</td>
						</tr>
						<tr>
							<td>projectData</td>
							<td>Project Data</td>
						</tr>
						<tr>
							<td>projectDataFolder</td>
							<td>Project Data Folder</td>
						</tr>
						<tr>
							<td>issueId</td>
							<td>Issue Id</td>
						</tr>
						<tr>
							<td>issueType</td>
							<td>Issue Type</td>
						</tr>
						<tr>
							<td>latitude</td>
							<td>����</td>
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
							<td>duration</td>
							<td>Duration</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;li&gt;
	&lt;button type="button" title="Shortcuts" onclick="gotoIssue('ifc_mep.json', '128', 'ISSUE_TYPE_BUGGER', '126.6086040', '37.583', '40', '2')"&gt;Shortcuts&lt;/button&gt;
	&lt;div class="info"&gt;
		&lt;p class="title"gt;&lt;span&gt;IFC(MEP)&lt;/span&gt; TEST&lt;/p&gt;
		&lt;ul class="tag"&gt;
			&lt;li&gt;&lt;span class="i1"&gt;&lt;/span&gt;Bugger&lt;/li&gt;
			&lt;li&gt;&lt;span class="t1"&gt;&lt;/span&gt;Very Important&lt;/li&gt;
			&lt;li class="date"&gt;2017-08-25 14:27:42&lt;/li&gt;
		&lt;/ul&gt;	
	&lt;/div&gt;
&lt;/li&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">function gotoIssue(projectId, issueId, issueType, longitude, latitude, height, duration) {
		var projectData = getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
		if (projectData === null || projectData === undefined) {
			$.ajax({
				url: dataInformationUrl + projectId,
				type: "GET",
				dataType: "json",
				success: function(serverData) {
					gotoIssueAPI(managerFactory, projectId, serverData, serverData.data_key, issueId, issueType, longitude, latitude, height, duration);		
				},
				error : function(request, status, error) {
					console.log("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
				}
			});
		} else {
			gotoIssueAPI(managerFactory, projectId, projectData, projectData.data_key, issueId, issueType, longitude, latitude, height, duration);	
		}
		
		// Save current coordinates
		saveCurrentLocation(latitude, longitude);
	}
</code>
				</pre>
			</article>	
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="mouseMoveAPI">mouseMoveAPI</span></h2>
				<p>An API that replaces button events with a mouse disabled environment (under development).</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>eventType</td>
							<td>Identify which mouse actions you want</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
			</article>
			<hr>	
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="searchDataAPI">searchDataAPI</span></h2>
				<p>API to retrieve data.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>Project Id</td>
						</tr>
						<tr>
							<td>dataKey</td>
							<td>Data unique key</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;local(Browser) Search&lt;/h3&gt;
	&lt;ul class="apiLoca"&gt;
		&lt;li&gt;
			&lt;label for="localSearchProjectId"&gt;Project &lt;/label&gt;
			&lt;select id="localSearchProjectId" name="localSearchProjectId" class="select"&gt;
				ProjectId
			&lt;/select&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="localSearchDataKey"&gt;Data Key&lt;/label&gt;
			&lt;input type="text" id="localSearchDataKey" name="localSearchDataKey" size="23" /&gt;
			&lt;button type="button" id="localSearch" class="btn"&gt;Search&lt;/button&gt; 
		&lt;/li&gt;
	&lt;/ul&gt;
&lt;/div&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">$("#localSearch").click(function() {
	if ($.trim($("#localSearchDataKey").val()) === ""){
		alert("Please enter your Data Key.");
		$("#localSearchDataKey").focus();
		return false;
	}
	searchDataAPI(managerFactory, $("#localSearchProjectId").val(), $("#localSearchDataKey").val());
});
</code>
				</pre>
			</article>
			<hr>			
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="isDataExistAPI">isDataExistAPI</span></h2>
				<p>It is an API that determines whether key value exists in environment setting data map.</p>
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
							<td>key</td>
							<td>Search Key</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">isDataExistAPI(CODE.PROJECT_ID_PREFIX + dataName)
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="getDataAPI">getDataAPI</span></h2>
				<p>It is an API that loads the data information (json) contained in the data amp.</p>
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
							<td>key</td>
							<td>Search Key</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
</code>
				</pre>
			</article>
			<hr>	
			<!-- getDataInfoByDataKey -->
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="getDataInfoByDataKeyAPI">getDataInfoByDataKeyAPI</span></h2>
				<p>An API that acquires the spatial information of dataInfo using the data key.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>Project Id</td>
						</tr>
						<tr>
							<td>dataKey</td>
							<td>Data unique key</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="drawAppendDataAPI">drawAppendDataAPI</span></h2>
				<p>API to add and Rendering project unit data.</p>
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
							<td>managerFactoryInstance</td>
							<td>mago3D starting point</td>
						</tr>
						<tr>
							<td>projectIdArray</td>
							<td>Project Id Array</td>
						</tr>
						<tr>
							<td>projectDataArray</td>
							<td>Project Data Array</td>
						</tr>
						<tr>
							<td>projectDataFolderArray</td>
							<td>Project Data Folder Array</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">drawAppendDataAPI(managerFactory, projectIdArray, projectDataArray, projectDataFolderArray);
</code>
				</pre>
			</article>	
		</div>
	</div>
</body>
</html>