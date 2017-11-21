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
				<li class="item"><span class="api_title"> <a href="#changeColorAPI">changeColorAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeLocationAndRotationAPI">changeLocationAndRotationAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeObjectMoveAPI">changeObjectMoveAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#saveObjectMoveAPI">saveObjectMoveAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#deleteAllObjectMoveAPI">deleteAllObjectMoveAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#deleteAllChangeColorAPI">deleteAllChangeColorAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeInsertIssueModeAPI">changeInsertIssueModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeObjectInfoViewModeAPI">changeObjectInfoViewModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeOcclusionCullingAPI">changeOcclusionCullingAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeFPVModeAPI">changeFPVModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeNearGeoIssueListViewModeAPI">changeNearGeoIssueListViewModeAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeInsertIssueStateAPI">changeInsertIssueStateAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeLodAPI">changeLodAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeLightingAPI">changeLightingAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changeSsaoRadiusAPI">changeSsaoRadiusAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#clearAllDataAPI">clearAllDataAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#drawInsertIssueImageAPI">drawInsertIssueImageAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#searchDataAPI">searchDataAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#getDataAPI">getDataAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#isDataExistAPI">isDataExistAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#changePropertyRenderingAPI">changePropertyRenderingAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#mouseMoveAPI">mouseMoveAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#gotoProjectAPI">gotoProjectAPI</a>
				</span></li>
				<li class="item"><span class="api_title"> <a href="#drawAppendDataAPI">drawAppendDataAPI</a>
				</span></li>
			</ul>
		</div>
		<div class="main" id="content">
<!-- 			<div class="header"> -->
<!-- 				<h2>mago3D JS API 목록</h2> -->
<%-- <%-- 				<img src="/images/${lang}/homepage/AC.png" style="margin-bottom: 10px;" /> --%> 
<!-- 			</div> -->
<!-- 			<div class="api_list"> -->
<!-- 				<table> -->
<!-- 					<thead> -->
<!-- 						<tr> -->
<!-- 							<th class="api_name">API 이름</th> -->
<!-- 							<th class="api_des">설명</th> -->
<!-- 						</tr> -->
<!-- 					</thead> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td><a href="#changeMagoStateAPI">changeMagoStateAPI</a></td> -->
<!-- 							<td>mago3D 상태 변경</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeBoundingBoxAPI</td> -->
<!-- 							<td>BoundingBox 표시/비표시</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeShadowAPI</td> -->
<!-- 							<td>그림자 표시/비표시</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeColorAPI</td> -->
<!-- 							<td>Color 변경</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeLocationAndRotationAPI</td> -->
<!-- 							<td>Location And Rotation 변경</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeObjectMoveAPI</td> -->
<!-- 							<td>마우스 클릭 객체 이동 대상 변경</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>saveObjectMoveAPI</td> -->
<!-- 							<td>모든 객체 마우스 이동 이력 저장(Cache)</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>deleteAllObjectMoveAPI</td> -->
<!-- 							<td>모든 객체 마우스 이동 이력 삭제(Cache)</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>deleteAllChangeColorAPI</td> -->
<!-- 							<td>모든 객체 색깔 변경 이력을 삭제(Cache)</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeInsertIssueModeAPI</td> -->
<!-- 							<td>이슈 등록 활성화 유무</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeObjectInfoViewModeAPI</td> -->
<!-- 							<td>object 정보 표시 활성화 유무</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeOcclusionCullingAPI</td> -->
<!-- 							<td>Object Occlusion culling</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeFPVModeAPI</td> -->
<!-- 							<td>1인칭, 3인칭 모드 변경(개발중)</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeNearGeoIssueListViewModeAPI</td> -->
<!-- 							<td>현재 위치 근처 issue 불러옴</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeInsertIssueStateAPI</td> -->
<!-- 							<td>issue 등록 geo 정보 관련 상태 변경</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeLodAPI</td> -->
<!-- 							<td>LOD(Level Of Detail 설정을 변경</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeLightingAPI</td> -->
<!-- 							<td>Lighting 설정 </td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changeSsaoRadiusAPI</td> -->
<!-- 							<td>SSAO Radius 설정</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>clearAllDataAPI</td> -->
<!-- 							<td>화면에 있는 모든 데이터를 삭제, 비표시</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>drawInsertIssueImageAPI</td> -->
<!-- 							<td>Pin Image를 그림</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>searchDataAPI</td> -->
<!-- 							<td>데이터 검색</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>getDataAPI</td> -->
<!-- 							<td>환경 설정 data map에서 key 값을 취득</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>isDataExistAPI</td> -->
<!-- 							<td>환경 설정 data map에 key 값의 존재 유무를 판별</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>changePropertyRenderingAPI</td> -->
<!-- 							<td>속성값에 의한 가시화 유무 설정</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>mouseMoveAPI</td> -->
<!-- 							<td>마우스를 사용할 수 없는 환경에서 버튼 이벤트로 대체(개발중)</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>gotoProjectAPI</td> -->
<!-- 							<td>해당 프로젝트를 로딩하고 이동</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td>drawAppendDataAPI</td> -->
<!-- 							<td>프로젝트 단위 데이터를 추가하고 Rendering</td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
<!-- 			</div> -->
<!-- 			<hr> -->
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
							<td>managerFactoryInstance</td>
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>isShow</td>
							<td>true: 활성화, false: 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;mago3D
	&lt;input type="radio" id="magoEnable" name="magoState" value="0" checked="checked" onclick="changeMagoState(true);" /&gt;
	&lt;label for="magoEnable"&gt; 활성화 &lt;/label&gt;
	&lt;input type="radio" id="magoDisable" name="magoState" value="1"  onclick="changeMagoState(false);" /&gt;
	&lt;label for="magoDisable"&gt; 비활성화 &lt;/label&gt;
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
							<td>managerFactory</td>
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>isShow</td>
							<td>true: 활성화, false: 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;
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
<code class="JavaScript">function changeBoundingBox(isShow) {
	$("input:radio[name='boundingBox']:radio[value='" + isShow + "']").prop("checked", true);
	changeBoundingBoxAPI(managerFactory, isShow);
}
</code>
			</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeShadowAPI">changeShadowAPI</span></h2>
				<p>그림자 표시 유무를 설정</p>
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
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>isShow</td>
							<td>true: 활성화, false: 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;Shadow
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
					프로젝트 단위로 원하는 데이터나 데이터의 객체에 색상을 변경해주는 API입니다.
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
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>프로젝트 아이디</td>
						</tr>
						<tr>
							<td>dataKey</td>
							<td>데이터 키</td>
						</tr>
						<tr>
							<td>objectIds</td>
							<td>object id. 복수개의 경우 , 로 입력</td>
						</tr>
						<tr>
							<td>property</td>
							<td>속성값 예)isMain=true</td>
						</tr>
						<tr>
							<td>color</td>
							<td>R, G, B 색깔을 ',' 로 연결한 string 값을 받음.</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;색깔 변경&lt;/h3&gt;
	&lt;ul class="apiLoca"&gt;
		&lt;li&gt;
			&lt;label for="colorProjectId"&gt;프로젝트 &lt;/label&gt;
			&lt;select id="colorProjectId" name="colorProjectId" class="select"&gt;
			...
			&lt;/select&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="colorDataKey"&gt;Data Key&lt;/label&gt;
			&lt;input type="text" id="colorDataKey" name="colorDataKey" size="30" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="colorObjectIds"&gt;Object Id&lt;/label&gt;
			&lt;input type="text" id="colorObjectIds" name="colorObjectIds" placeholder="   , 구분" size="30" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="colorProperty"&gt;속성&lt;/label&gt;
			&lt;input type="text" id="colorProperty" name="colorProperty" size="30" placeholder="isMain=true" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="updateColor"&gt;색깔&lt;/label&gt;
			&lt;select id="updateColor" name="updateColor" class="select"&gt;
				&lt;option value="255,0,0"&gt; 빨강 &lt;/option&gt;
				&lt;option value="255,255,0"&gt; 노랑 &lt;/option&gt;
				&lt;option value="0,255,0"&gt; 녹색 &lt;/option&gt;
				&lt;option value="0,0,255"&gt; 파랑 &lt;/option&gt;
				&lt;option value="255,0,255"&gt; 분홍 &lt;/option&gt;
				&lt;option value="0,0,0"&gt; 검정 &lt;/option&gt;
			&lt;/select&gt;
			&lt;button type="button" id="changeColor" class="btn"&gt;변경&lt;/button&gt; 
		&lt;/li&gt;
	&lt;/ul&gt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#changeColor").click(function(e) {
	if ($.trim($("#colorDataKey").val()) === ""){
		alert("Data Key를 입력해 주세요.");
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
							<td>managerFactoryInstance</td>
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>프로젝트 아이디</td>
						</tr>
						<tr>
							<td>dataKey</td>
							<td>데이터 키</td>
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
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div>
	&lt;h3&gt;Location and Rotation&lt;/h3&gt;
	&lt;ul class="apiLoca"&gt;
		&lt;li&gt;
			&lt;label for="moveProjectId"&gt;프로젝트 &lt;/label&gt;
			&lt;select id="moveProjectId" name="moveProjectId" class="select"&gt;
				&lt;option value="data.json"&gt;...&lt;/option&gt;
			&lt;/select&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="moveDataKey"&gt;Data Key&lt;/label&gt;
			&lt;input type="text" id="moveDataKey" name="moveDataKey" size="25" /&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="moveLatitude"&gt;위도 &lt;/label&gt;
			&lt;input type="text" id="moveLatitude" name="moveLatitude" size="25"/&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="moveLongitude"&gt;경도 &lt;/label&gt;
			&lt;input type="text" id="moveLongitude" name="moveLongitude" size="25"/&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="moveHeight"&gt;높이 &lt;/label&gt;
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
			&lt;button type="button" id="changeLocationAndRotation" class="btn"&gt;변환&lt;/button&gt; 
		&lt;/li&gt;
	&lt;/ul&gt;
&lt;/div&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#changeLocationAndRotation").click(function() {
	if(!changeLocationAndRotationCheck()) return false;
	changeLocationAndRotationAPI(	managerFactory, $("#moveProjectId").val(),
							$("#moveDataKey").val(), $("#moveLatitude").val(), $("#moveLongitude").val(), 
							$("#moveHeight").val(), $("#moveHeading").val(), $("#movePitch").val(), $("#moveRoll").val());
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeObjectMoveAPI">changeObjectMoveAPI</span></h2>
				<p>마우스 클릭 객체 이동 대상 변경</p>
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
							<td>mago3D 시작 부분</td>
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
				<p>모든 객체 마우스 이동 이력을 Cache로 저장합니다.</p>
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
							<td>mago3D 시작 부분</td>
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
<code>&lt;button type="button" id="saveObjectMoveButton" class="btn"&gt;저장&lt;/button&gt;	
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#saveObjectMoveButton").click(function () {
	alert("준비중 입니다.");
	var objectMoveMode = $(':radio[name="objectMoveMode"]:checked').val();
	if(objectMoveMode === "2") {
		alert("None 모드일 경우 저장할 수 없습니다.");
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
				<p>모든 객체 마우스 이동 이력을 Cache로 삭세합니다.</p>
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
							<td>mago3D 시작 부분</td>
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
<code>&lt;button type="button" id="deleteAllObjectMoveButton" class="btn"&gt;전체 삭제&lt;/button&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#deleteAllObjectMoveButton").click(function () {
	var objectMoveMode = $(':radio[name="objectMoveMode"]:checked').val();
	if(confirm("삭제 하시겠습니까?")) {
		deleteAllObjectMoveAPI(managerFactory, objectMoveMode);
	}
});
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="deleteAllChangeColorAPI">deleteAllChangeColorAPI</span></h2>
				<p>변경한 색상 이력을 전체 삭제합니다.</p>
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
							<td>mago3D 시작 부분</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;button type="button" id="deleteAllChangeColor" class="btn"&gt;전체 삭제&lt;/button&gt;
</code>
			</pre>
				<br> <b>JavaScript</b>
				<pre>
<code>$("#deleteAllChangeColor").click(function () {
	if(confirm("삭제 하시겠습니까?")) {
		deleteAllChangeColorAPI(managerFactory);
	}
});
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
							<td>managerFactoryInstance</td>
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>flag</td>
							<td>true = 활성화, false = 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;button type="button" id="insertIssueEnableButton" class="btn"&gt;클릭 후 객체를 선택해 주세요.&lt;/button&gt; 
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code>$("#insertIssueEnableButton").click(function() {
	if(insertIssueEnable) {
		$("#insertIssueEnableButton").removeClass("on");
		$("#insertIssueEnableButton").text("클릭 후 객체를 선택해 주세요.");
		insertIssueEnable = false;
	} else {
		$("#insertIssueEnableButton").addClass("on");
		$("#insertIssueEnableButton").text("Issue 등록 활성화 상태");
		insertIssueEnable = true;
	}
	changeInsertIssueModeAPI(managerFactory, insertIssueEnable);
});
</code>
			</pre>
			<br><b>mago3DJS로 부터 호출 되는 callback 함수</b>
			<pre>
<code class=javascript>function showInsertIssueLayer(data_key, object_key, latitude, longitude, height) {
	if(insertIssueEnable) {
		$("#data_key").val(data_key);
		$("#object_key").val(object_key);
		$("#latitude").val(latitude);
		$("#longitude").val(longitude);
		$("#height").val(height);
		
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
							<td>managerFactoryInstance</td>
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>flag</td>
							<td>true = 활성화, false = 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<br><b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;Object 정보&lt;/h3&gt;
	&lt;input type="radio" id="showObjectInfo" name="objectInfo" value="true" onclick="changeObjectInfoViewMode(true);" /&gt;
	&lt;label for="showObjectInfo"&gt; 표시 &lt;/label&gt;
	&lt;input type="radio" id="hideObjectInfo" name="objectInfo" value="false" onclick="changeObjectInfoViewMode(false);"/&gt;
	&lt;label for="hideObjectInfo"&gt; 비표시 &lt;/label&gt;
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
				<br><b>mago3DJS로 부터 호출 되는 callback 함수</b>
				<pre>
<code>function showSelectedObject(dataKey, objectId, latitude, longitude, height, heading, pitch, roll) {
	var objectInfoViewFlag = $(':radio[name="objectInfo"]:checked').val();
	if(objectInfoViewFlag) {
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
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>flag</td>
							<td>true = 활성화, false = 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;Object Occlusion Culling&lt;/h3&gt;
	&lt;div&gt;
		&lt;div&gt;사용유무&lt;/div&gt;
		&lt;input type="radio" id="useOcclusionCulling" name="occlusionCulling" value="true" /&gt;
		&lt;label for="useOccusionCulling"&gt; 사용 &lt;/label&gt;
		&lt;input type="radio" id="unusedOcclusionCulling" name="occlusionCulling" value="false" /&gt;
		&lt;label for="unusedOcclusionCulling"&gt; 미사용 &lt;/label&gt;
	&lt;/div&gt;
	&lt;div&gt;
		&lt;div&gt;Data Key&lt;/div&gt;
		&lt;input type="text" id="occlusion_culling_data_key" name="occlusion_culling_data_key"/&gt;
		&lt;button type="button" id="changeOcclusionCullingButton" class="btn"&gt;변경&lt;/button&gt;
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
				<p>카메라를 1인칭, 3인칭 모드로 변경해주는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>flag</td>
							<td>true = 활성화, false = 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
			    <b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;View Mode&lt;/h3&gt;
	&lt;input type="radio" id="mode3PV" name="viewMode" value ="false" onclick="changeViewMode(false);"/&gt;
	&lt;label for="mode3PV"&gt; 3인칭 모드 &lt;/label&gt;
	&lt;input type="radio" id="mode1PV" name="viewMode" value ="true" onclick="changeViewMode(true);"/&gt;
	&lt;label for="mode1PV"&gt; 1인칭 모드 &lt;/label&gt;
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
				<p>활성화시 현재 위치 근처 issue를 보여주는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>flag</td>
							<td>true = 활성화, false = 비활성화</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;현재 위치 근처 Issue List(100개)&lt;/h3&gt;
	&lt;input type="radio" id="showNearGeoIssueList" name="nearGeoIssueList" value="true" onclick="changeNearGeoIssueList(true);" /&gt;
	&lt;label for="showNearGeoIssueList"&gt; 표시 &lt;/label&gt;
	&lt;input type="radio" id="hideNearGeoIssueList" name="nearGeoIssueList" value="false" onclick="changeNearGeoIssueList(false);"/&gt;
	&lt;label for="hideNearGeoIssueList"&gt; 비표시 &lt;/label&gt;
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
							<td>managerFactoryInstance</td>
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>insertIssueState</td>
							<td>이슈 등록 좌표 상태</td>
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
				<p>LOD(Level Of Detail)설정을 변경해주는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
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
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;LOD&lt;/h3&gt;
	&lt;div&gt;LOD0&lt;/div&gt;
	&lt;input type="text" id="geo_lod0" name="geo_lod0" value="22" size="15" /&gt;&nbsp;M
	&lt;div&gt;LOD1&lt;/div&gt;
	&lt;input type="text" id="geo_lod1" name="geo_lod1" value="70" size="15" /&gt;&nbsp;M
	&lt;div&gt;LOD2&lt;/div&gt;
	&lt;input type="text" id="geo_lod2" name="geo_lod2" value="22360" size="15" /&gt;&nbsp;M&nbsp;&nbsp;
	&lt;button type="button" id="changeLodButton" class="btn"&gt;변경&lt;/button&gt;
&lt;/div&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">$("#changeLodButton").click(function() {
	changeLodAPI(managerFactory, $("#geo_lod0").val(), $("#geo_lod1").val(), $("#geo_lod2").val(), null);
});
</code>
				</pre>
			</article>
			<hr>
				<article class="api_description" style="margin-top: 50px;">
				<h2><span id="changeLightingAPI">changeLightingAPI</span></h2>
				<p>선택한 Object에 밝기를 조절하는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
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
			&lt;button type="button" id="changeLightingButton" class="btn"&gt;변경&lt;/button&gt;
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
				<p>선택한 Object에 SSAO Radius를 설정해주는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
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
	&lt;button type="button" id="changeSsaoRadiusButton" class="btn"&gt;변경&lt;/button&gt;
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
				<p>화면에 있는 모든 데이터를 삭제, 비표시하는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
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
				<p>Pin Image를 그려주는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
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
				<h2><span id="searchDataAPI">searchDataAPI</span></h2>
				<p>데이터를 검색해주는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>프로젝트 아이디</td>
						</tr>
						<tr>
							<td>dataKey</td>
							<td>데이터 고유키</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;div&gt;
	&lt;h3&gt;로컬(Browser) 검색&lt;/h3&gt;
	&lt;ul class="apiLoca"&gt;
		&lt;li&gt;
			&lt;label for="localSearchProjectId"&gt;프로젝트 &lt;/label&gt;
			&lt;select id="localSearchProjectId" name="localSearchProjectId" class="select"&gt;
				ProjectId
			&lt;/select&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="localSearchDataKey"&gt;Data Key&lt;/label&gt;
			&lt;input type="text" id="localSearchDataKey" name="localSearchDataKey" size="23" /&gt;
			&lt;button type="button" id="localSearch" class="btn"&gt;검색&lt;/button&gt; 
		&lt;/li&gt;
	&lt;/ul&gt;
&lt;/div&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">$("#localSearch").click(function() {
	if ($.trim($("#localSearchDataKey").val()) === ""){
		alert("Data Key를 입력해 주세요.");
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
				<h2><span id="getDataAPI">getDataAPI</span></h2>
				<p>data amp에 담겨있는 데이터정보(json)를 불러오는 API입니다.</p>
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
							<td>검색 키</td>
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
				<h2><span id="isDataExistAPI">isDataExistAPI</span></h2>
				<p>환경 설정 data map에 key 값의 존재 유무를 판별하는 API입니다.</p>
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
							<td>검색 키</td>
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
				<h2><span id="isDataExistAPI">changePropertyRenderingAPI</span></h2>
				<p>속성값에 의한 가시화 유무설정하는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>isShow</td>
							<td>true = 표시, false = 비표시</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>프로젝트 아이디</td>
						</tr>
						<tr>
							<td>property</td>
							<td>속성</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code class="html">&lt;div&gt;
	&lt;h3&gt;속성 가시화&lt;/h3&gt;
	&lt;ul class="apiLoca"&gt;
		&lt;li&gt;
			&lt;input type="radio" id="showPropertyRendering" name="propertyRendering" value="true" /&gt;
			&lt;label for="showLabel"&gt; 표시 &lt;/label&gt;
			&lt;input type="radio" id="hidePropertyRendering" name="propertyRendering" value="false" /&gt;
			&lt;label for="hideLabel"&gt; 비표시 &lt;/label&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="propertyRenderingProjectId"&gt;프로젝트 &lt;/label&gt;
			&lt;select id="propertyRenderingProjectId" name="propertyRenderingProjectId" class="select"&gt;
				&lt;option value="data.json"&gt;...&lt;/option&gt;
			&lt;/select&gt;
		&lt;/li&gt;
		&lt;li&gt;
			&lt;label for="propertyRenderingWord"&gt;속성&lt;/label&gt;
			&lt;input type="text" id="propertyRenderingWord" name="propertyRenderingWord" size="23" placeholder="isMain=true" /&gt;
			&lt;button type="button" id="changePropertyRendering" class="btn"&gt;변경&lt;/button&gt; 
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
		alert("표시/비표시 를 선택하여 주십시오..");
		return false;
	}
	if ($.trim($("#propertyRenderingWord").val()) === ""){
		alert("속성값을 입력해 주세요.");
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
				<h2><span id="mouseMoveAPI">mouseMoveAPI</span></h2>
				<p>마우스를 사용할 수 없는 환경에서 버튼 이벤트로 대체하는 API입니다.(개발중)</p>
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
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>eventType</td>
							<td>어떤 마우스 동작을 원하는지를 구분</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="gotoProjectAPI">gotoProjectAPI</span></h2>
				<p>해당 프로젝트를 로딩하고 그 프로젝트로 이동하는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>projectId</td>
							<td>프로젝트 아이디</td>
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
							<td>duration</td>
							<td>이동하는 시간</td>
						</tr>
					</tbody>
				</table>
				<h4>Examples:</h4>
				<b>html</b>
				<pre>
<code>&lt;ul&gt;
	&lt;li onclick="gotoProject('data.json', '126.5252421', '35.425', '550', '3')"&gt;data&lt;/li&gt;
	&lt;li onclick="gotoProject('data.json', '126.5252421', '35.425', '550', '3')"&gt;data&lt;/li&gt;
	&lt;li onclick="gotoProject('data.json', '126.5252421', '35.425', '550', '3')"&gt;data&lt;/li&gt;
&lt;/ul&gt;
</code>
				</pre>
				<br><b>JavaScript</b>
				<pre>
<code class="javascript">function gotoProject(projectId, longitude, latitude, height, duration) {
	//console.log("url = " + dataInformationUrl + projectId);
	var projectData = getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
	if (projectData === null || projectData === undefined) {
		$.ajax({
			url: dataInformationUrl + projectId,
			type: "GET",
			dataType: "json",
			success: function(serverData){
				gotoProjectAPI(managerFactory, projectId, serverData, serverData.data_key, longitude, latitude, height, duration);		
			},
			error:function(request,status,error){
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	} else {
		gotoProjectAPI(managerFactory, projectId, projectData, projectData.data_key, longitude, latitude, height, duration);	
	}
	
	// 현재 좌표를 저장
	$("#now_latitude").val(latitude);
	$("#now_longitude").val(longitude);
}
</code>
				</pre>
			</article>
			<hr>
			<article class="api_description" style="margin-top: 50px;">
				<h2><span id="drawAppendDataAPI">drawAppendDataAPI</span></h2>
				<p>프로젝트 단위 데이터를 추가하고 Rendering하는 API입니다.</p>
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
							<td>mago3D 시작 부분</td>
						</tr>
						<tr>
							<td>projectIdArray</td>
							<td>프로젝트 이름들</td>
						</tr>
						<tr>
							<td>projectDataArray</td>
							<td>프로젝트 데이터들</td>
						</tr>
						<tr>
							<td>projectDataFolderArray</td>
							<td>프로젝트 f4d 파일 경로</td>
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