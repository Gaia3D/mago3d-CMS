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
				<p>MAGO3D는 AEC(Architecture, Engineering, Construction) 영역과 전통적인 3차원 공간정보(3D GIS)를 통합적으로 관리, 가시화해 주는 차세대 3차원 플랫폼입니다. MAGO3D는 기존의 솔루션과 달리 실내외 구별 없이 끊김 없이 AEC와 3D GIS를 웹 브라우저에서 통합해 줍니다. 이에 따라, MAGO3D 사용자는 초대용량 BIM(Building Information Modelling), JT(Jupiter Tessellation), 3D GIS 파일 등을 별도의 프로그램 설치 없이 웹 브라우저 상에서 바로 살펴보고 협업작업을 진행할 수 있습니다.
				<p>
				<h4>Mssion</h4>
				<p>Mago3DJS 3차원 다중 블록 가시화를 위한 오픈소스 자바스크립트 라이브러리를 사용한 가시화 데이터를 통합 과제 | 이슈 관리를 할 수 있습니다.</p>
				<h4>Features</h4>
				<ul class="readme_list">
					<li>이슈 현황 신규 이슈, 진행 중인 이슈, 완료된 이슈를 볼 수 있습니다.</li>
					<li>사용자 상태별 현황을 그래프로 되어 있어 보기 편합니다.</li>
					<li>DB Connection Pool 현황이나 DV세션 현황을 테이블로 볼 수 있습니다.</li>
				</ul>
				<h4>Development Environment</h4>
				<mark>Spring, gradle, PostgreSQL, PostGIS, mybatis, Docker</mark>
				<h4>Getting Started</h4>
				<div class="list_wrap">
					<div class="sub_title">Install</div>
					<ul class="readme_list">
						<li><b style="color: #1E90FF;">Postgres</b>
							<ul class="sub_list">
								<li> PostgreSQL 버전 설정 (PostgreSQL v9.6.3-1)</li>
								<li> 설치경로 C:/PostgreSQL</li>
								<li> 비밀번호 설정 Password: postgres Retype Password: postgres</li>
							</ul>
						</li>
						<li><b style="color: #1E90FF;">PostGIS</b>
							<ul class="sub_list">
								<li>PostgreSQL 설치가 끝난 뒤에 Stack Builder를 실행하여 설치</li>
								<li>PostGIS 버전 설정 (PostGIS v2.3.2)</li>
								<li>PostgreSQL Extensions PostGIS 필수</li>
							</ul>
						</li>
						<li><b style="color: #1E90FF;">gradle</b>
							<ul class="sub_list">
								<li>gradle 버전 설치 (gradle v3.5)</li>
								<li>설치경로 C:/gradle</li>
								<li>시스템 변수 추가 -path -> C:/gradle/gradle-3.5 추가</li>
						
							</ul>
						</li>
						<li><b style="color: #1E90FF;">lombok</b>
							<ul class="sub_list">
								<li> 설치한 뒤에 다운로드 폴더 이동 후 실행 </li>
								<li>eclipse 설치 위치 [Specify location..]를 검색해서 'eclipse.exe' 파일을 선택합니다.</li>
								<li>install/update 클릭합니다.</li>
							</ul>
						</li>
						<li><b style="color: #1E90FF;">Buildship Gradle Integration</b>
							<ul class="sub_list">
								<li>eclipse Help -> Eclipse Marketplace 이동 후 Buildship Gradle Integration 2.0을 설치합니다.</li>
							</ul>
						</li>
					</ul>
					<div class="sub_title">Setting</div>
					<ul class="readme_list">
						<li>eclipse에서 mago3D Project를 git clone으로 불러옵니다.</li>
						<li>File -> Import -> Gradle -> Existing Gradle Project를 클릭하여 mago3D를 받아줍니다.</li>
						<li>mago3D를 실행하기전에 PostgreSQL을 사용하여 데이터베이스를 만들어 줍니다.</li>
						<li>PostgreSQL -> new DataBase</li>
						<li>생성한 database에 쿼리를 실행시켜줍니다. 쿼리는 mago3D-core -> src -> doc -> database 안에 있습니다.</li>
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
						<li>mago3D를 실행하려면 mago3d-@@@ -> src/main/java -> com.gaia3d -> Mago3dAdminApplication.java를 Spring Boot app으로 실행시켜줍니다.</li>
					</ul>
				</div>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeMagoStateAPI">changeMagoStateAPI()</span></h2>
				<p>mago3D 활성화 상태 값을 변경함으로서 화면에 mago3D Object 가 표시, 비표시 됩니다.</p>
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
				<p>Block의 BoundingBox 표시 유무를 설정</p>
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
&lt;div&gt;BoundingBox
	&lt;input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBoxAPI(true);" /&gt;
	&lt;label for="showBoundingBox"&gt; 표시 &lt;/label&gt;
	&lt;input type="radio" id="hideBoundingBox" name="boundingBox" value="false"  onclick="changeBoundingBoxAPI(false);" /&gt;
	&lt;label for="hideBoundingBox"&gt; 비표시 &lt;/label&gt;
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
				<p>블락의 Structure, Outfitting 그림자 표시 유무를 설정</p>
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
	&lt;input type="radio" id="showShadow" name="shadow" value="true" onclick="changeShadowAPI(true);" /&gt;
	&lt;label for="showShadow"&gt; 표시 &lt;/label&gt;
	&lt;input type="radio" id="hideShadow" name="boundingBox" value="false"  onclick="changeShadowAPI(false);" /&gt;
	&lt;label for="hideShadow"&gt; 비표시 &lt;/label&gt;
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
&lt;input type="text" id="frustumFarDistance" name="frustumFarDistance" placeholder="미터(m)" size=4" /&gt;
&lt;button type="button" id="changeFrustumFarDistanceAPI" class="btn btn-default btn-sm">적용&lt;/button&gt;
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
	&lt;span  style="padding-left: 10px; padding-right: 100px;"&gt;Data Key&lt;/span&gt;
	&lt;input type="text" id="search_data_key" name="search_data_key" size="15" /&gt;
	&lt;button type="button" id="searchData" style="width: 50px; background: #727272; font-size: 1.2rem;">검색&lt;/button&gt;
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
	&lt;input type="text" id="objectIds" name="objectIds" placeholder=", 구분 입력" size=21" /&gt;
	&lt;button type="button" id="changeColorAPI" class="btn btn-default btn-sm">변경&lt;/button&gt;
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
			&lt;input type="text" id="move_data_key" name="move_data_key" size="15" /&gt;
		&lt;/span&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;span&gt;
			&lt;label for="move_latitude"&gt;위도&lt;/label&gt;
			&lt;input type="text" id="move_latitude" name="move_latitude" size="15" /&gt;
		&lt;/span&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;span&gt;
			&lt;label for="move_longitude"&gt;경도&lt;/label&gt;
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
			&lt;button type="button" id="changeLocationAndRotationAPI">변환&lt;/button&gt;
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
				<p>마우스 클릭 객체 이동 대상 변경합니다</p>
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
							<td>0이면 전체, 1이면 object</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>
&lt;div&gt;마우스 이동모드
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
				<p>이슈 등록 활성화 유무</p>
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
				<p>object 정보 표시 활성화 유무</p>
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
<code>
&lt;button id="issuesEnable"&gt;Issues 표시&lt;/button&gt;
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
				<p>Pin image를 그림</p>
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
				<b>html</b>
				<pre>
<code>
if(msg.result == "success") {
				alert(JS_MESSAGE["insert"]);
				// pin image를 그림
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
				<p>issue 등록 geo 정보 관련 상태 변경</p>
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
				<p>마우스를 사용할 수 없는 환경에서 버튼 이벤트로 대체</p>
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
							<td>어떤 마우스 동작을 원하는지를 구분</td>
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