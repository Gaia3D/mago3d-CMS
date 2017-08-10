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
				<p>3차원 다중 블록 가시화를 위한 오픈소스 자바스크립트 라이브러리</p>
				<p>AEC(Architecture, Engineering, Construction) 영역과 전통적인 3차원 공간정보(3D GIS)를 통합적으로 관리 및 가시화하는 차세대 3차원 GIS 플랫폼입니다. 실내,실 외 구별없이 AEC와 3D GIS를 웹 브라우저에서 통합해 줍니다. 대용량 BIM(Building Information Modelling), JT(Jupiter Tessellation), 3D GIS 파일 등을 별도의 프로그램 설치 없이 웹 브라우저 상에서 바로 살펴보고 협업작업을 진행할 수 있습니다.</p>
				<h4>Development Environment</h4>
				<div class="list_wrap">
					<p><mark>java8, eclipse neon, node, apache, Jasmine, Jsdoc, Gulp, eslint, JQuery</mark>
				</div>
				<h4>Getting Started</h4>
				<div class="list_wrap">
					<ul class="readme_list">
						<li><b style="color: #1E90FF;">mago3DJS Install</b>
							<ul class="sub_list">
								<li><a href="https://github.com/Gaia3D/mago3djs" style="display: inline;"><b>github</b></a>에서 mago3DJS를 받아 줍니다.</li>
								<li> 설치경로 C:/git/repository/mago3djs</li>
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
						<li><b style="color: #1E90FF;">서버 실행</b>
							<ul class="sub_list">
								<li>Local 서버 실행:  C:\git\repository\mago3djs> node server.js</li>
								<li>public 서버 실행:  C:\git\repository\mago3djs> node server.js --public true</li>
							</ul>
						</li>
					</ul>
					<ul class="readme_list">
						<li><b style="color: #1E90FF;">데이터 폴더 링크</b>
							<ul class="sub_list">
								<li>데이터 폴더 생성: mklink /d "C:\git\repository\mago3djs\data" "C:\data"</li>
								<li>데이터 폴더 삭제: C:\git\repository\mago3djs>rmdir data</li>
							</ul>
						</li>
					</ul>
				</div>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeMagoStateAPI">changeMagoStateAPI</span></h2>
				<p>mago3D 활성화 상태 값을 변경함으로서 화면에 mago3D Object가 표시, 비표시 됩니다.</p>
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
							<td>true: 활성화, false: 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;mago3D
	&lt;input type="radio" id="magoEnable" name="magoState" value="0" checked="checked" onclick="changeMagoState(true);" /&gt;
	&lt;label for="magoEnable"&gt; 활성화 &lt;/label&gt;
	&lt;input type="radio" id="magoDisable" name="magoState" value="1"  onclick="changeMagoState(false);" /&gt;
	&lt;label for="magoDisable"&gt; 비활성화 &lt;/label&gt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>
function changeMagoState(isShow) {
	changeMagoStateAPI(isShow);
}
</code>
			</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeBoundingBoxAPI">changeBoundingBoxAPI</span></h2>
				<p>changeBoundingBoxAPI 활성화 상태 값을 변경함으로서 BoundingBox가 표시, 비표시 됩니다.</p>
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
							<td>true: 활성화, false: 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;
	&lt;span&gt;BoundingBox&lt;/span&gt;
	&lt;input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBox(true);" /&gt;
	&lt;label for="showBoundingBox"&gt; 표시 &lt;/label&gt;
	&lt;input type="radio" id="hideBoundingBox" name="boundingBox" value="false"  onclick="changeBoundingBox(false);" /&gt;
	&lt;label for="hideBoundingBox"&gt; 비표시 &lt;/label&gt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code class="JavaScript">
function changeBoundingBox(isShow) {
	changeBoundingBoxAPI(isShow);
}
</code>
			</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeShadowAPI">changeShadowAPI</span></h2>
				<p>changeShadowAPI 활성화 상태 값을 변경함으로서 블락의 Structure, Outfitting 그림자가 표시, 비표시 됩니다</p>
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
							<td>true: 활성화, false: 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;Shadow
	&lt;input type="radio" id="showShadow" name="shadow" value="true" onclick="changeShadow(true);" /&gt;
	&lt;label for="showShadow"&gt; 표시 &lt;/label&gt;
	&lt;input type="radio" id="hideShadow" name="shadow" value="false"  onclick="changeShadow(false);" /&gt;
	&lt;label for="hideShadow"&gt; 비표시 &lt;/label&gt;
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
				<p>입력 받은 거리의 제곱값을 이용해서 Frustum Culling 거리를 설정합니다.</p>
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
							<td>frustum 거리. 내부적으로는 입력값의 제곱이 사용됨</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;label for="frustumFarDistance"&gt; 가시 거리 &lt;/label&gt;
&lt;input type="text" id="frustumFarDistance" name="frustumFarDistance" placeholder="미터(m)"/&gt;
&lt;button type="button" id="changeFrustumFarDistanceAPI" class="btn btn-default btn-sm">적용&lt;/button&gt;
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
				<p>데이터 고유키를 입력받아, 카메라 위치를 이동합니다.</p>
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
							<td>검색을 원하는 blockId</td>
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
	&lt;button type="button" id="searchData">검색&lt;/button&gt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>
$("#searchData").click(function() {
	if ($.trim($("#search_data_key").val()) === ""){
		alert("Data Key를 입력해 주세요.");
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
					입력받은 Object 를 입력받은 color 로 변경 표시합니다.<br> Object정보를 ','로 구분해서 복수 입력 가능합니다.
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
							<td>object id. 복수개의 경우 , 로 입력</td>
						</tr>
						<tr>
							<td>color</td>
							<td>R, G, B 색깔을 ',' 로 연결한 string 값을 받음</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;
	&lt;label for="objectIds"&gt;Object Id 입력 &lt;/label&gt;
	&lt;input type="text" id="objectIds" name="objectIds" placeholder=", 구분 입력"/&gt;
	&lt;label for="colorBlock"&gt;색깔&lt;/label/&gt;
	&lt;select id="colorBlock" name="colorBlock"/&gt;
		&lt;option value=""&gt; 없음 &lt;/option/&gt;
		&lt;option value="255,0,0"&gt; 빨강 &lt;/option/&gt;
		&lt;option value="255,255,0"&gt; 노랑&lt;/option/&gt;
		&lt;option value="0,255,0"&gt; 녹색 &lt;/option/&gt;
		&lt;option value="0,0,255"&gt; 파랑 &lt;/option/&gt;
		&lt;option value="255,0,255"&gt; 분홍 &lt;/option/&gt;
		&lt;option value="0,0,0"&gt; 검정 &lt;/option/&gt;
	&lt;/select&gt;
	&lt;button type="button" id="changeColorAPI" class="btn btn-default btn-sm"&gt;변경&lt;/button&gt;
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
				<p>입력 받은 위치정보와 회전 정보로 블록을 변환 시킵니다.</p>
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
							<td>위도</td>
						</tr>
						<tr>
							<td>longitude</td>
							<td>경도</td>
						</tr>
						<tr>
							<td>height</td>
							<td>높이</td>
						</tr>
						<tr>
							<td>heading</td>
							<td>좌, 우</td>
						</tr>
						<tr>
							<td>pitch</td>
							<td>위, 아래</td>
						</tr>
						<tr>
							<td>roll</td>
							<td>좌, 우 기울기</td>
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
			&lt;label for="move_latitude"&gt;위도&lt;/label&gt;
			&lt;input type="text" id="move_latitude" name="move_latitude"/&gt;
		&lt;/span&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;span&gt;
			&lt;label for="move_longitude"&gt;경도&lt;/label&gt;
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
			&lt;button type="button" id="changeLocationAndRotationAPI">변환&lt;/button&gt;
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
				<p>마우스를 클릭할 때 이동 모드를 변경할 수 있습니다. mouseMoveMode가 0이면 전체이동, 1이면 객체이동, 2이면 이동이 불가능해집니다.</p>
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
				<p>changeInsertIssueModeAPI란 이슈 기능을 활성화하는 API입니다. 이 API에 파라미터인 flag는 Boolean 타입이고  true이면 이슈 모드가 활성화되고 
				false이면 비활성화되는 방식입니다. 활성화되어있는 상태에서 이슈를 등록하고 싶은 Object를 클릭하면 callback함수를 관리해주는 데이터베이스 운영정책에 따라서 이슈등록 callback함수가 호출이되어 
				이슈등록 창이 나옵니다. 이슈등록 창에 내용을 적고 저장하면 데이터베이스에 등록이됩니다. 또한, 이슈등록 callback함수는 사용자가 Customizing이 가능합니다.</p>
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
							<td>true = 활성화, false = 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;button id="issueEnable"&gt;Issue 등록&lt;/button&gt;
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
			<br><b>mago3DJS로 부터 호출 되는 callback 함수</b>
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
			
			// 현재 좌표를 저장
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
				<p>changeObjectInfoViewModeAPI는 Object정보표시 기능을 활성화하는 API입니다. 이 API에 파라미터인 flag는 Boolean 타입이고 true이면 정보 표시 
				모드가 활성화되고 false이면 비활성화되는 방식입니다. 활성화되어있는 상태에서 정보를 알고 싶은 Object를 클릭하면 callback함수를 관리해주는 데이터베이스 운영정책에 따라서 정보표시 callback함수가 
				호출되고 Jquery Plugin Toast통하여 Object정보가 나옵니다. 또한, 정보표시 callback함수는 사용자가 Customizing이 가능합니다.</p>
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
							<td>true = 활성화, false = 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>html</b>
				<pre>
<code>
&lt;div&gt;
	&lt;button id="objectInfoEnable"&gt;Object 정보&lt;/button&gt;	
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
				<br><b>mago3DJS로 부터 호출 되는 callback 함수</b>
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
		
		// 현재 좌표를 저장
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
				<p>now_latitude, now_longitude를 가지고 데이터 그룹에 있는 그룹 중에 가장 가까운 그룹 위치를 찾고 그 데이터 그룹에 속하는 issue 100개를 가져와서 보여줍니다.</p>
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
							<td>true = 활성화, false = 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">
&lt;button id="issuesEnable"&gt;Issues 표시&lt;/button&gt;
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
		
		// 현재 위치의 latitude, logitude를 가지고 가장 가까이에 있는 데이터 그룹에 속하는 이슈 목록을 최대 100건 받아서 표시
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
				<p>Pin Image를 그려줍니다. drawType이 0 이면 DB, 1 이면 이슈등록</p>
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
							<td>이미지를 그리는 유형 0 : DB, 1 : 이슈등록</td>
						</tr>
						<tr>
							<td>issue_id</td>
							<td>이슈 고유키</td>
						</tr>
						<tr>
							<td>issue_type</td>
							<td>이슈 고유키</td>
						</tr>
						<tr>
							<td>data_key</td>
							<td>데이터 고유키</td>
						</tr>
						<tr>
							<td>latitude</td>
							<td>데이터 고유키</td>
						</tr>
						<tr>
							<td>longitude</td>
							<td>데이터 고유키</td>
						</tr>
						<tr>
							<td>height</td>
							<td>데이터 고유키</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br> <b>JavaScript</b>
				<pre>
<code>
drawInsertIssueImageAPI(0, issue.issue_id, issue.issue_type, issue.data_key, issue.latitude, issue.longitude, issue.height);
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeInsertIssueStateAPI">changeInsertIssueStateAPI</span></h2>
				<p>mago3DJS 엔진이 이슈 등록을 위해서 좌표를 기억하고 있었는데 changeInsertIssueStateAPI에 파라미터에 0을 넘겨 주면 좌표를 초기화합니다.</p>
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
							<td>이슈 등록 좌표 상태</td>
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