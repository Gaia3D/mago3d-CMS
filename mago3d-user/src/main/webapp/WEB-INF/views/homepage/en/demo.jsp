<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>demo | mago3D User</title>
	<link rel="stylesheet" href="/css/${lang}/homepage-demo.css?cache_version=${cache_version}" />
<c:if test="${geoViewLibrary == null || geoViewLibrary eq '' || geoViewLibrary eq 'cesium' }">
	<link rel="stylesheet" href="/externlib/${lang}/cesium/Widgets/widgets.css?cache_version=${cache_version}" />
</c:if>	
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css?cache_version=${cache_version}" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-toast/jquery.toast.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-toast/jquery.toast.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/js/${lang}/message.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
<input type="hidden" id="now_latitude" name="now_latitude" value="${now_latitude }" />
<input type="hidden" id="now_longitude" name="now_longitude" value="${now_longitude }"  />

<ul class="nav">
	<li id="homeMenu" class="home">
		<img src="/images/ko/homepage/home-icon.png" style="width: 35px; height: 35px; padding-right: 2px;"/>
	</li>
	<li id="myIssueMenu" class="issue" data-tooltip-text="Shows the latest 10 issues sorted chronologically from the entire Issue List.">Issue<span id="issueListCount">${totalCount }</span></li>
	<li id="searchMenu" class="search" data-tooltip-text="searching such as issue, object, and spatial information.">Search</li>
	<li id="apiMenu" class="api" data-tooltip-text="APIs to control various functions of mago3D.">API</li>	
	<li id="insertIssueMenu" class="regist" data-tooltip-text="Issue registration for Object.">Regist.</li>
	<li id="configMenu" class="config" data-tooltip-text="Settings related to rendering.">Settings</li>	
</ul>

<div id="menuContent" class="navContents">
	<div class="alignRight">
		<button type="button" id="menuContentClose" class="navClose">Close</button>
	</div>
	
	<ul id="homeMenuContent" class="menuList">
		<li><a href="/homepage/index.do">Home</a></li>
		<li><a href="/homepage/about.do">mago3D</a></li>
		<li>Demo
			<ul>
<c:if test="${geoViewLibrary == null || geoViewLibrary eq '' || geoViewLibrary eq 'cesium' }">
				<li>Cesium</li>
				<li><a href="/homepage/demo.do?viewLibrary=worldwind">World Wind</a></li>
</c:if>				
<c:if test="${geoViewLibrary eq 'worldwind' }">				
				<li><a href="/homepage/demo.do?viewLibrary=cesium">Cesium</a></li>
				<li>World Wind</li>
</c:if>		
			</ul>
		</li>
		<li><a href="/homepage/download.do">Download</a></li>
		<li>Documentation
			<ul>
				<li><a href="http://www.mago3d.com/homepage/api.do">API</a></li>
				<li><a href="http://www.mago3d.com/homepage/spec.do">F4D Spec</a></li>
			</ul>
		</li>
		<li><a href="/homepage/faq.do">FAQ</a></li>
	</ul>
	
	<ul id="myIssueMenuContent" class="issueList">
		<li style="margin-bottom: 8px; font-size: 1em; font-weight: normal; color: #2955a6;">
			Show up to 10 latest issues.
		</li>
<c:if test="${empty issueList }">
		<li style="text-align: center; padding-top:20px; height: 50px;">
			The issue does not exist.
		</li>
</c:if>
<c:if test="${!empty issueList }">
	<c:forEach var="issue" items="${issueList}" varStatus="status">
		<li>
			<button type="button" title="Shortcuts" onclick="flyTo('${issue.issue_id}', '${issue.issue_type}', '${issue.longitude}', '${issue.latitude}', '${issue.height}', '2')">Shortcuts</button>
			<div class="info">
				<p class="title">
					<span>${issue.data_group_name }</span>
					${issue.title }
				</p>
				<ul class="tag">
					<li><span class="${issue.issue_type_css_class }"></span>${issue.issue_type_name }</li>
					<li><span class="${issue.priority_css_class }"></span>${issue.priority_name }</li>
					<li class="date">${issue.viewInsertDate }</li>
				</ul>
			</div>
		</li>
	</c:forEach>
</c:if>
	</ul>
	
	<form:form id="searchForm" modelAttribute="issue" method="post" onsubmit="return false;">
	<div id="searchMenuContent" class="searchWrap">
		<table>
			<tr style="height: 35px;">
				<td style="width: 80px;"><label for="data_group_id">Data Group</label></td>
				<td><select id="data_group_id" name="data_group_id" class="select">
					<option value=""> ALL </option>
<c:forEach var="dataGroup" items="${projectDataGroupList}">
					<option value="${dataGroup.data_group_id}">${dataGroup.data_group_name}</option>
</c:forEach>
				</select></td>
			</tr>
			<tr style="height: 35px;">
				<td><label for="search_word">Category</label></td>
				<td>
					<select id="search_word" name="search_word" class="select">
						<option value="data_name">Data Name</option>
						<option value="title">Issue Name</option>
					</select>
					<select id="search_option" name="search_option" class="select">
						<option value="1">Included</option>
						<option value="0">Matches</option>
					</select>
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
				<label for="search_value">Search Word</label></td>
				<td><input type="text" id="search_value" name="search_value" size="31" /></td>
			</tr>
			<tr style="height: 35px;">
				<td><label for="start_date">Date</label></td>
				<td><input type="text" class="s date" id="start_date" name="start_date" size="12" />
				<span class="delimeter tilde">~</span>
				<input type="text" class="s date" id="end_date" name="end_date" size="12" /></td>
			</tr>
			<tr style="height: 30px;">
				<td><label for="order_word">View Order</label></td>
				<td><select style="width:85px;" id="order_word" name="order_word" class="select">
					<option value=""> Basic </option>
			       	<option value="register_date"> Registration Date </option>
				</select>
				<select style="width:85px;" id="order_value" name="order_value" class="select">
					<option value=""> Basic </option>
				   	<option value="ASC"> Ascending </option>
					<option value="DESC"> Descending </option>
				</select>
				<select style="width:85px;" id="list_counter" name="list_counter" class="select">
					<option value="5"> listing 5 </option>
				 	<option value="10"> listing 10 </option>
					<option value="50"> listing 50 </option>
				</select>
				</td>
			</tr>
		</table>
		<div class="btns">
			<button type="button" id="searchData" class="full">Search</button>
		</div>
		<ul id="searchList" class="searchList"></ul>
	</div>
	</form:form>
	
	<div id="apiMenuContent" class="apiWrap">
		<div>
			<h3>Location and Rotation</h3>
			<ul class="apiLoca">
				<li>
					<label for="move_data_key">Data Key</label>
					<input type="text" id="move_data_key" name="move_data_key" size="25" />
				</li>
				<li>
					<label for="move_latitude">Latitude</label>
					<input type="text" id="move_latitude" name="move_latitude" size="25"/>
				</li>
				<li>
					<label for="move_longitude">Longitude</label>
					<input type="text" id="move_longitude" name="move_longitude" size="25"/>
				</li>
				<li>
					<label for="move_height">Altitude</label>
					<input type="text" id="move_height" name="move_height" size="25" />
				</li>
				<li>
					<label for="move_heading">Heading</label>
					<input type="text" id="move_heading" name="move_heading" size="25" />
				</li>
				<li>
					<label for="move_pitch">Pitch</label>
					<input type="text" id="move_pitch" name="move_pitch" size="25" />
				</li>
				<li>
					<label for="move_roll">Roll</label>
					<input type="text" id="move_roll" name="move_roll" size="25" />
					<button type="button" id="changeLocationAndRotationAPI" class="btn">Transform</button> 
				</li>
			</ul>
		</div>
		<div>
			<h3>Issue Lists(100) near current location</h3>
			<input type="radio" id="showNearGeoIssueList" name="nearGeoIssueList" value="true" onclick="changeNearGeoIssueList(true);" />
			<label for="showNearGeoIssueList"> Show </label>
			<input type="radio" id="hideNearGeoIssueList" name="nearGeoIssueList" value="false" onclick="changeNearGeoIssueList(false);"/>
			<label for="hideNearGeoIssueList"> Hide </label>
		</div>
		<div>
			<h3>About the location of the click point</h3>
			<ul class="apiLoca">
				<li>
					<label for="positionLatitude"> Latitude </label>
					<input type="text" id="positionLatitude" name="positionLatitude" size="25" />
				</li>
				<li>
					<label for="positionLongitude"> Longitude </label>
					<input type="text" id="positionLongitude" name="positionLongitude" size="25" />
				</li>
				<li>
					<label for="positionAltitude"> Altitude </label>
					<input type="text" id="positionAltitude" name="positionAltitude" size="25" />
				</li>
			</ul>
		</div>
	</div>
	
	<form:form id="issue" modelAttribute="issue" method="post" onsubmit="return false;">
	<div id="insertIssueMenuContent" class="insertIssueWrap">
		<table>
			<tr style="height: 35px;">
				<td style="width: 100px;" nowrap="nowrap">
					<form:label path="data_group_id">Data Group</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:select path="data_group_id" cssClass="select">
<c:forEach var="dataGroup" items="${projectDataGroupList}">
						<option value="${dataGroup.data_group_id}">${dataGroup.data_group_name}</option>
</c:forEach>
					</form:select>
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<form:label path="issue_type">Type</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:select path="issue_type" cssClass="select">
<c:forEach var="commonCode" items="${issueTypeList}">
						<option value="${commonCode.code_key}">${commonCode.code_name_en}</option>
</c:forEach>
					</form:select>
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					Issue Location
				</td>
				<td>
					<button type="button" id="insertIssueEnableButton" class="btn">Please select object after click.</button> 
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<form:label path="data_key">Data Name</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:input path="data_key" readonly="true" size="25" cssStyle="background-color: #CBCBCB;" />
					<form:errors path="data_key" cssClass="error" />
					<form:hidden path="object_key"/>
					<form:hidden path="height"/>
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<form:label path="latitude">Latitude</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:input path="latitude" readonly="true" size="25" cssStyle="background-color: #CBCBCB;" />
					<form:errors path="latitude" cssClass="error" />
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<form:label path="longitude">Longitude</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:input path="longitude" readonly="true" size="25" cssStyle="background-color: #CBCBCB;" />
					<form:errors path="longitude" cssClass="error" />
				</td>
			</tr>
			<tr style="height: 60px;">
				<td><form:label path="title">Title</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:textarea path="title" rows="2" cols="32" />
					<form:errors path="title" cssClass="error" />
				</td>
			</tr>
			
			<tr style="height: 35px;">
				<td><form:label path="priority">Priority</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:select path="priority" cssClass="select">
<c:forEach var="commonCode" items="${issuePriorityList}">
						<option value="${commonCode.code_key}">${commonCode.code_name_en}</option>
</c:forEach>
					</form:select>
				</td>
			</tr>
			
			<tr style="height: 35px;">
				<td><form:label path="due_day">Due Date</form:label></td>
				<td><form:hidden path="due_date" />
					<input type="text" id="due_day" name="due_day" class="date" size="10" maxlength="10" />
					D&nbsp;&nbsp;
					<input type="text" id="due_hour" name="due_hour" placeholder=" 00" size="2" maxlength="2" /> :
					<input type="text" id="due_minute" name="due_minute" placeholder=" 00" size="2" maxlength="2" />
					M
				</td>
			</tr>
			
			<tr style="height: 35px;">
				<td><form:label path="assignee">Assignee</form:label></td>
				<td><form:input style="font-size:13px;" path="assignee" cssClass="m" placeholder="assignee" size="24" />
					<button type="button" class="btn" onclick="alert('Comming Soon...');">Select</button> 
					<form:errors path="assignee" cssClass="error" />
				</td>
			</tr>
			
			<tr style="height: 35px;">
				<td><form:label path="reporter">Reporter</form:label></td>
				<td><form:input style="font-size:13px;" path="reporter" cssClass="m" placeholder="reporter" size="24" />
					<button type="button" class="btn" onclick="alert('Comming Soon...');">Select</button> 
					<form:errors path="reporter" cssClass="error" />
				</td>
			</tr>
			
			<tr>
				<td><form:label path="contents">Contents</form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td><form:textarea path="contents" rows="5" cols="32" />
					<form:errors path="contents" cssClass="error" />
				</td>
			</tr>
		</table>
		
		<div class="btns">
				<button type="button" id="issueSaveButton" class="full">Save</button>
			</div>
	</div>
	</form:form>
	
	<div id="configMenuContent" class="configWrap">
		<div>
			<h3>Label</h3>
			<input type="radio" id="showLabel" name="labelInfo" value="true" onclick="changeLabel(true);" />
			<label for="showLabel"> Show </label>
			<input type="radio" id="hideLabel" name="labelInfo" value="false" onclick="changeLabel(false);"/>
			<label for="hideLabel"> Hide </label>
		</div>
		<div>
			<h3>Object Information</h3>
			<input type="radio" id="showObjectInfo" name="objectInfo" value="true" onclick="changeObjectInfoViewMode(true);" />
			<label for="showObjectInfo"> Show </label>
			<input type="radio" id="hideObjectInfo" name="objectInfo" value="false" onclick="changeObjectInfoViewMode(false);"/>
			<label for="hideObjectInfo"> Hide </label>
		</div>
		<div>
			<h3>Bounding Box</h3>
			<input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBox(true);" />
			<label for="showBoundingBox"> Show </label>
			<input type="radio" id="hideBoundingBox" name="boundingBox" value="false" onclick="changeBoundingBox(false);"/>
			<label for="hideBoundingBox"> Hide </label>
		</div>
		<div>
			<h3>Object Occlusion Culling</h3>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">Select</div>
				<input type="radio" id="useOcclusionCulling" name="occlusionCulling" value="true" />
				<label for="useOccusionCulling"> use </label>
				<input type="radio" id="unusedOcclusionCulling" name="occlusionCulling" value="false" />
				<label for="unusedOcclusionCulling"> unused </label>
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">Data Key</div>
				<input type="text" id="occlusion_culling_data_key" name="occlusion_culling_data_key" size="23" />
				<button type="button" id="changeOcclusionCullingButton" class="btn">Change</button>
			</div>
		</div>
		<div>
			<h3>Selecting And Moving</h3>
			<input type="radio" id="mouseNoneMove" name="mouseMoveMode" value="2" onclick="changeMouseMove('2');"/>
			<label for="mouseNoneMove"> None </label>
			<input type="radio" id="mouseAllMove" name="mouseMoveMode" value="0" onclick="changeMouseMove('0');"/>
			<label for="mouseAllMove"> ALL </label>
			<input type="radio" id="mouseObjectMove" name="mouseMoveMode" value="1" onclick="changeMouseMove('1');"/>
			<label for="mouseObjectMove"> Object </label>
		</div>
		<div>
			<h3>LOD</h3>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">LOD0</div>
				<input type="text" id="geo_lod0" name="geo_lod0" value="22" size="19" />&nbsp;M
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">LOD1</div>
				<input type="text" id="geo_lod1" name="geo_lod1" value="70" size="19" />&nbsp;M
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">LOD2</div>
				<input type="text" id="geo_lod2" name="geo_lod2" value="22360" size="19" />&nbsp;M&nbsp;&nbsp;
				<button type="button" id="changeLodButton" class="btn">Change</button>
			</div>
		</div>
		<div>
			<h3>Lighting</h3>
			<div style="height: 30px;">AmbientReflectionCoeficient</div>
			<div id="ambient_reflection_coef" style="display: inline-block; width: 228px;">
				<div id="geo_ambient_reflection_coef_view" class="ui-slider-handle"></div>
				<input type="hidden" id="geo_ambient_reflection_coef" name="geo_ambient_reflection_coef" value="0.5" />
			</div>
			<div style="height: 30px;">DiffuseReflectionCoeficient</div>
			<div id="diffuse_reflection_coef" style="display: inline-block; width: 228px;">
				<div id="geo_diffuse_reflection_coef_view" class="ui-slider-handle"></div>
				<input type="hidden" id="geo_diffuse_reflection_coef" name="geo_diffuse_reflection_coef" value="1" />
			</div>
			<div style="height: 30px;">SpecularReflectionCoeficient</div>
			<div>
				<div id="specular_reflection_coef" style="display: inline-block; width: 228px;">
					<div id="geo_specular_reflection_coef_view" class="ui-slider-handle"></div>
					<input type="hidden" id="geo_specular_reflection_coef" name="geo_specular_reflection_coef" value="1" />
				</div>
				<div style="float: right;">
					<button type="button" id="changeLightingButton" class="btn">Change</button>
				</div>
			</div>
			<!-- <div style="height: 30px;">
				<label for="geo_ambient_color">AmbientColor</label>
				<input type="text" id="geo_ambient_color" name="geo_ambient_color" class="m" size="15"
					data-palette='[	"#c00000","#ff0000","#ffc000","#ffff00","#92d050",
									"#00b050","#00b0f0","#0070c0","#002060","#7030a0",
									"#f2f2f2","#d8d8d8","#bfbfbf","#a5a5a5","#7f7f7f",
									"#7f7f7f","#595959","#3f3f3f","#262626","#0c0c0c",
									"#ddd9c3","#c4bd97","#938953","#494429","#1d1b10",
									"#c6d9f0","#8db3e2","#548dd4","#17365d","#0f243e",
									"#dbe5f1","#b8cce4","#95b3d7","#366092","#244061",
									"#f2dcdb","#e5b9b7","#d99694","#953734","#632423",
									"#ebf1dd","#d7e3bc","#c3d69b","#76923c","#4f6128",
									"#e5e0ec","#ccc1d9","#b2a2c7","#5f497a","#3f3151",
									"#dbeef3","#b7dde8","#92cddc","#31859b","#205867",
									"#fdeada","#fbd5b5","#fac08f","#e36c09","#974806" ]' />
			</div>
			<div style="height: 30px;">
				<label for="geo_specular_color">SpecularColor</label>
				<input type="text" id="geo_specular_color" name="geo_specular_color" class="m" size="15"
					data-palette='[ "#c00000","#ff0000","#ffc000","#ffff00","#92d050",
									"#00b050","#00b0f0","#0070c0","#002060","#7030a0",
									"#f2f2f2","#d8d8d8","#bfbfbf","#a5a5a5","#7f7f7f",
									"#7f7f7f","#595959","#3f3f3f","#262626","#0c0c0c",
									"#ddd9c3","#c4bd97","#938953","#494429","#1d1b10",
									"#c6d9f0","#8db3e2","#548dd4","#17365d","#0f243e",
									"#dbe5f1","#b8cce4","#95b3d7","#366092","#244061",
									"#f2dcdb","#e5b9b7","#d99694","#953734","#632423",
									"#ebf1dd","#d7e3bc","#c3d69b","#76923c","#4f6128",
									"#e5e0ec","#ccc1d9","#b2a2c7","#5f497a","#3f3151",
									"#dbeef3","#b7dde8","#92cddc","#31859b","#205867",
									"#fdeada","#fbd5b5","#fac08f","#e36c09","#974806" ]' />
				&nbsp;
			</div> -->
			<div style="text-align: center">
			</div>
		</div>
		<div>
			<h3><label for="geo_ssao_radius">SSAO Radius</label></h3>
			<input type="text" id="geo_ssao_radius" name="geo_ssao_radius" />
			<button type="button" id="changeSsadRadiusButton" class="btn">Change</button>
		</div>
		<div>
			<h3>View Mode</h3>
			<input type="radio" id="mode3PV" name="viewMode" value ="false" onclick="changeViewMode(false);"/>
			<label for="mode3PV"> Third person mode </label>
			<input type="radio" id="mode1PV" name="viewMode" value ="true" onclick="changeViewMode(true);"/>
			<label for="mode1PV"> First-person mode </label>
		</div>
	</div>
</div>

<ul class="shortcut">
	<c:forEach var="dataGroup" items="${projectDataGroupList}" varStatus="status">
	<li onclick="flyTo(null, null, '${dataGroup.longitude}', '${dataGroup.latitude}', '${dataGroup.height}', '${dataGroup.duration}')">${dataGroup.data_group_name }</li>
	</c:forEach>	
</ul>

<!-- 맵영역 -->
<c:if test="${geoViewLibrary == null || geoViewLibrary eq '' || geoViewLibrary eq 'cesium' }">
<div id="magoContainer" class="mapWrap"></div>
<canvas id="objectLabel"></canvas>
</c:if>
<c:if test="${geoViewLibrary eq 'worldwind' }">
<div style="position: absolute; width: 100%; height: 100%; margin-top: 0; padding: 0; overflow: hidden;">
	<canvas id="magoContainer" style="width: 100%; height: 100%">
        Your browser does not support HTML5 Canvas.
    </canvas>
    <canvas id="objectLabel"></canvas>
</div>
</c:if>

<c:if test="${geoViewLibrary == null || geoViewLibrary eq '' || geoViewLibrary eq 'cesium' }">
<script type="text/javascript" src="/externlib/${lang}/cesium/Cesium.js?cache_version=${cache_version}"></script>
</c:if>
<c:if test="${geoViewLibrary eq 'worldwind' }">
<script type="text/javascript" src="/externlib/${lang}/webworldwind/worldwind.js?cache_version=${cache_version}"></script>
</c:if>
<script type="text/javascript" src="/js/${lang}/mago3d.js?cache_version=${cache_version}"></script>
<script>
	var agent = navigator.userAgent.toLowerCase();
	if(agent.indexOf('chrome') < 0) { 
		alert("This page is optimized for the Chrome browser for massive data processing.\nPlease use the Chrome browser for seamless service.");
	}

	var policyJson = ${policyJson};
	var dataGroupMap = ${dataGroupMap};
	var menuMap = new Map();
	menuMap.set("homeMenu", false);
	menuMap.set("myIssueMenu", false);
	menuMap.set("searchMenu", false);
	menuMap.set("apiMenu", false);
	menuMap.set("insertIssueMenu", false);
	menuMap.set("configMenu", false);
	var insertIssueEnable = false;
	var FPVModeFlag = false;
	var imagePath = "/images/${lang}";
	var managerFactory = new ManagerFactory(null, "magoContainer", policyJson, dataGroupMap, imagePath);
	
	$(document).ready(function() {
		initJqueryCalendar();
		// Label 표시
		changeLabel(false);
		// object 정보 표시
		changeObjectInfoViewMode(false);
		// BoundingBox
		changeBoundingBox(false);
		// Selecting And Moving
		changeMouseMove("2");
		// slider, color-picker
		initRendering();
		// 3PView Mode
		changeViewMode(false);
	});
	
	function flyTo(issueId, issueType, longitude, latitude, height, duration) {
		managerFactory.flyTo(issueId, issueType, longitude, latitude, height, duration);
		// 현재 좌표를 저장
		$("#now_latitude").val(latitude);
		$("#now_longitude").val(longitude);
	}
	
	// issue 위치 버튼을 클릭 했을 경우
	$("#insertIssueEnableButton").click(function() {
		if(insertIssueEnable) {
			$("#insertIssueEnableButton").removeClass("on");
			$("#insertIssueEnableButton").text("Please select object after click.");
			insertIssueEnable = false;
		} else {
			$("#insertIssueEnableButton").addClass("on");
			$("#insertIssueEnableButton").text("Issue registration is active.");
			insertIssueEnable = true;
		}
		changeInsertIssueModeAPI(insertIssueEnable);
	});
	// issue input layer call back function
	function showInsertIssueLayer(data_key, object_key, latitude, longitude, height) {
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
	
	var isInsertIssue = true;
	$("#issueSaveButton").click(function() {
		if (check() == false) {
			return false;
		}
		if(isInsertIssue) {
			isInsertIssue = false;
			var info = $("#issue").serialize();		
			$.ajax({
				url: "/issue/ajax-insert-issue.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
						// pin image를 그림
						drawInsertIssueImageAPI(1, msg.issue.issue_id, msg.issue.issue_type, $("#data_key").val(), $("#latitude").val(), $("#longitude").val(), $("#height").val());
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					
					isInsertIssue = true;
					ajaxIssueList();
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			        isInsertIssue = true;
				}
			});
			
			// issue 등록 버튼, css, 상태를 변경
			$("#insertIssueEnableButton").removeClass("on");
			$("#insertIssueEnableButton").text("Please select object after click.");
			insertIssueEnable = false;
			
			changeInsertIssueStateAPI(0);
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	function check() {
		if ($("#data_key").val() == "") {
			alert(JS_MESSAGE["issue.datakey.empty"]);
			$("#data_key").focus();
			return false;
		}
		if ($("#title").val() == "") {
			alert(JS_MESSAGE["issue.title.empty"]);
			$("#title").focus();
			return false;
		}
		if ($("#contents").val() == "") {
			alert(JS_MESSAGE["issue.contents.empty"]);
			$("#contents").focus();
			return false;
		}
	}
	
	// TODO issue url 밑에 있어야 할지도 모르겠다.
	function ajaxIssueList() {
		var info = "";		
		$.ajax({
			url: "/homepage/ajax-list-issue.do",
			type: "GET",
			data: info,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					var issueList = msg.issueList;
					var content = "";
					var issueListCount = 0;
					content = content 
						+	"<li style=\"margin-bottom: 8px; font-size: 1em; font-weight: normal; color: #2955a6;\">"
						+ 		"Show up to 10 latest issues"
						+	"</li>";
					if(issueList == null || issueList.length == 0) {
						content += 	"<li style=\"text-align: center; padding-top:20px; height: 50px;\">"
								+	"	The issue does not exist."
								+	"</li>";
					} else {
						issueListCount = issueList.length;
						for(i=0; i<issueListCount; i++ ) {
							var issue = issueList[i];
							content = content 
								+ 	"<li>"
								+ 	"	<button type=\"button\" title=\"Shortcuts\""
								+			"onclick=\"flyTo('" + issue.issue_id + "', '" + issue.issue_type + "', '" 
								+ 				issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2')\">Shortcuts</button>"
								+ 	"	<div class=\"info\">"
								+ 	"		<p class=\"title\">"
								+ 	"			<span>" + issue.data_group_name + "</span>"
								+ 				issue.title
								+ 	"		</p>"
								+ 	"		<ul class=\"tag\">"
								+ 	"			<li><span class=\"" + issue.issue_type_css_class + "\"></span>" + issue.issue_type_name + "</li>"
								+ 	"			<li><span class=\"" + issue.priority_css_class + "\"></span>" + issue.priority_name + "</li>"
								+ 	"			<li class=\"date\">" + issue.insert_date.substring(0,19) + "</li>"
								+ 	"		</ul>"
								+ 	"	</div>"
								+ 	"</li>";
						}
					}
					$("#issueListCount").empty();
					$("#issueListCount").html(msg.totalCount);
					$("#myIssueMenuContent").empty();
					$("#myIssueMenuContent").html(content);
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

	// 왼쪽 메뉴 클릭시 ui 처리
	$("#homeMenu").click(function() {
		menuSlideControl("homeMenu");
	});
	$("#myIssueMenu").click(function() {
		menuSlideControl("myIssueMenu");
	});
	$("#searchMenu").click(function() {
		menuSlideControl("searchMenu");
	});
	$("#apiMenu").click(function() {
		menuSlideControl("apiMenu");
	});
	$("#insertIssueMenu").click(function() {
		menuSlideControl("insertIssueMenu");
	});
	$("#configMenu").click(function() {
		menuSlideControl("configMenu");
	});
	function menuSlideControl(menuName) {
		var compareMenuState = menuMap.get(menuName);
		for(var [key, value] of menuMap) {
			// state 값 변경하고, css 변경
			if(key === menuName) {
				if(value) {
					$("#" + menuName).removeClass("on");
					$("#menuContent").hide();
					$("#" + menuName + "Content").hide();
				} else {
					$("#" + menuName).addClass("on");
					$("#menuContent").show();
					$("#" + menuName + "Content").show();
				}
				menuMap.set(menuName, !compareMenuState);
			} else {
				$("#" + key).removeClass("on");
				$("#" + key + "Content").hide();
			}
		}
	}
	
	// menu content close 버튼
	$("#menuContentClose").click(function() {
		for(var [key, value] of menuMap) {
			if(value) {
				$("#menuContent").hide();
				$("#" + key + "Content").hide();
				$("#" + key).removeClass("on");
				menuMap.set(key, !value);
			}
		}
		// 이슈 등록 비활성화 상태
		changeInsertIssueStateAPI(0);
	});
	
	// 검색 메뉴 시작
	// Data 검색
	var searchDataFlag = true;
	$("#searchData").click(function() {
		if ($.trim($("#search_value").val()) === ""){
			alert("Please enter a search word.");
			$("#search_value").focus();
			return false;
		}
		
		if(searchDataFlag) {
			searchDataFlag = false;
			var info = $("#searchForm").serialize();		
			$.ajax({
				url: "/homepage/ajax-list-issue.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						var searchType = $("#search_word").val();
						var content = "";
						if(searchType === "data_name") {
							var dataInfoList = msg.dataInfoList;
							if(dataInfoList == null || dataInfoList.length == 0) {
								content = content	
									+ 	"<li style=\"text-align: center; padding-top:20px; height: 50px;\">"
									+	"	Data does not exist."
									+	"</li>";
							} else {
								dataInfoListCount = dataInfoList.length;
								for(i=0; i<dataInfoListCount; i++ ) {
									var dataInfo = dataInfoList[i];
									content = content 
										+ 	"<li>"
										+ 	"	<button type=\"button\" title=\"Shortcuts\""
										+			"onclick=\"flyToBounding('" + dataInfo.data_key + "');\">Shortcuts</button>"
										+ 	"	<div class=\"info\">"
										+ 	"		<p class=\"title\">"
										+ 	"			<span>" + dataInfo.data_group_name + "</span>"
										+ 				dataInfo.data_name
										+ 	"		</p>"
										+ 	"		<ul class=\"tag\">"
										+ 	"			<li><span class=\"t3\"></span>" + dataInfo.latitude + "</li>"
										+ 	"			<li><span class=\"t3\"></span>" + dataInfo.longitude + "</li>"
										+ 	"			<li class=\"date\">" + dataInfo.insert_date.substring(0,19) + "</li>"
										+ 	"		</ul>"
										+ 	"	</div>"
										+ 	"</li>";
								}
							}
						} else {
							var issueList = msg.issueList;
							if(issueList == null || issueList.length == 0) {
								content = content	
									+ 	"<li style=\"text-align: center; padding-top:20px; height: 50px;\">"
									+	"	Issue does not exist."
									+	"</li>";
							} else {
								issueListCount = issueList.length;
								for(i=0; i<issueListCount; i++ ) {
									var issue = issueList[i];
									content = content 
										+ 	"<li>"
										+ 	"	<button type=\"button\" title=\"Shortcuts\""
										+			"onclick=\"flyTo('" + issue.issue_id + "', '" + issue.issue_type + "', '" 
										+ 				issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2')\">Shortcuts</button>"
										+ 	"	<div class=\"info\">"
										+ 	"		<p class=\"title\">"
										+ 	"			<span>" + issue.data_group_name + "</span>"
										+ 				issue.title
										+ 	"		</p>"
										+ 	"		<ul class=\"tag\">"
										+ 	"			<li><span class=\"" + issue.issue_type_css_class + "\"></span>" + issue.issue_type_name + "</li>"
										+ 	"			<li><span class=\"" + issue.priority_css_class + "\"></span>" + issue.priority_name + "</li>"
										+ 	"			<li class=\"date\">" + issue.insert_date.substring(0,19) + "</li>"
										+ 	"		</ul>"
										+ 	"	</div>"
										+ 	"</li>";
								}
							}
						}
						
						$("#searchList").empty();
						$("#searchList").html(content);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					searchDataFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					searchDataFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	
	function flyToBounding(dataKey) {
		searchDataAPI(dataKey);
	}
	
	// API 메뉴시작
	// object 정보 표시 call back function
	function showSelectedObject(data_key, objectId, latitude, longitude, height, heading, pitch, roll) {
		var objectInfoViewFlag = $(':radio[name="objectInfo"]:checked').val();
		if(objectInfoViewFlag) {
			$("#move_data_key").val(data_key);
			$("#move_latitude").val(latitude);
			$("#move_longitude").val(longitude);
			$("#move_height").val(height);
			$("#move_heading").val(heading);
			$("#move_pitch").val(pitch);
			$("#move_roll").val(roll);
			
			$.toast({
			    heading: 'Click Object Info',
			    text: [
			    	'dataKey : ' + data_key, 
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
			$("#occlusion_culling_data_key").val(data_key);
			// 현재 좌표를 저장
			$("#now_latitude").val(latitude);
			$("#now_longitude").val(longitude);
		}
	}
	// 변환행렬
	$("#changeLocationAndRotationAPI").click(function() {
		if(!changeLocationAndRotationCheck()) return false;
		changeLocationAndRotationAPI(	$("#move_data_key").val(), $("#move_latitude").val(), $("#move_longitude").val(), 
										$("#move_height").val(), $("#move_heading").val(), $("#move_pitch").val(), $("#move_roll").val());
	});
	function changeLocationAndRotationCheck() {
		if ($.trim($("#move_data_key").val()) === ""){
			alert("Please enter data key.");
			$("#move_data_key").focus();
			return false;
		}
		if ($.trim($("#move_latitude").val()) === ""){
			alert("Please enter latitude.");
			$("#move_latitude").focus();
			return false;
		}
		if ($.trim($("#move_longitude").val()) === ""){
			alert("Please enter longitude.");
			$("#move_longitude").focus();
			return false;
		}
		if ($.trim($("#move_height").val()) === ""){
			alert("Please enter altitude.");
			$("#move_height").focus();
			return false;
		}
		if ($.trim($("#move_heading").val()) === ""){
			alert("Please enter heading.");
			$("#move_heading").focus();
			return false;
		}
		if ($.trim($("#move_pitch").val()) === ""){
			alert("Please enter pitch.");
			$("#move_pitch").focus();
			return false;
		}
		if ($.trim($("#move_roll").val()) === ""){
			alert("Please enter roll.");
			$("#move_roll").focus();
			return false;
		}
		return true;
	}
	
	// 인접 지역 이슈 표시
	function changeNearGeoIssueList(isShow) {
		$("input:radio[name='nearGeoIssueList']:radio[value='" + isShow + "']").prop("checked", true);
		if(isShow) {
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
							for(i=0; i<issueList.length; i++ ) {
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
		changeNearGeoIssueListViewModeAPI(isShow);
	}
	
	// 설정 메뉴 시작
	// Label 표시
	function changeLabel(isShow) {
		$("input:radio[name='labelInfo']:radio[value='" + isShow + "']").prop("checked", true);
		changeLabelAPI(isShow);
	}
	// object info 표시
	function changeObjectInfoViewMode(isShow) {
		$("input:radio[name='objectInfo']:radio[value='" + isShow + "']").prop("checked", true);
		changeObjectInfoViewModeAPI(isShow);
	}
	// boundingBox 표시/비표시
	function changeBoundingBox(isShow) {
		$("input:radio[name='boundingBox']:radio[value='" + isShow + "']").prop("checked", true);
		changeBoundingBoxAPI(isShow);
	}
	// Object Occlusion culling
	$("#changeOcclusionCullingButton").click(function () {
		changeOcclusionCullingAPI(($(':radio[name="occlusionCulling"]:checked').val() === "true"), $("#occlusion_culling_data_key").val());		
	});
	// 마우스 클릭 객체 이동 모드 변경
	function changeMouseMove(mouseMoveMode) {
		$("input:radio[name='mouseMoveMode']:radio[value='" + mouseMoveMode + "']").prop("checked", true);
		changeMouseMoveAPI(mouseMoveMode);
	}
	// 카메라 모드 전환
	function changeViewMode(isFPVMode) {
		$("input:radio[name='viewMode']:radio[value='" + isFPVMode + "']").prop("checked", true);
		changeFPVModeAPI(isFPVMode);
	}
	
	// rendering 설정
	function initRendering() {
		var ambient = $( "#geo_ambient_reflection_coef_view" );
		$( "#ambient_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '0.5', // default value of slider
			create: function() {
				ambient.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				ambient.text( ui.value);
				$("#geo_ambient_reflection_coef" ).val(ui.value);
			}
		});
		var diffuse = $( "#geo_diffuse_reflection_coef_view" );
		$( "#diffuse_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '1.0', // default value of slider
			create: function() {
				diffuse.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				diffuse.text( ui.value);
				$("#geo_diffuse_reflection_coef" ).val(ui.value);
			}
		});
		var specular = $( "#geo_specular_reflection_coef_view" );
		$( "#specular_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '1.0', // default value of slider
			create: function() {
				specular.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				specular.text( ui.value);
				$("#geo_specular_reflection_coef" ).val(ui.value);
			}
		});
		
		/* $('[name="geo_ambient_color"]').paletteColorPicker({
			clear_btn: 'last',
			//position: 'downside',
			close_all_but_this: true // Default is false
		});
		$('[name="geo_specular_color"]').paletteColorPicker({
			clear_btn: 'last',
			//position: 'downside',
			close_all_but_this: true // Default is false
		}); */
	}
	
	// LOD 설정
	$("#changeLodButton").click(function() {
		changeLodAPI($("#geo_lod0").val(), $("#geo_lod1").val(), $("#geo_lod2").val(), null);
	});
	// Lighting 설정
	$("#changeLightingButton").click(function() {
		changeLightingAPI(	$("#geo_ambient_reflection_coef").val(), $("#geo_diffuse_reflection_coef").val(), $("#geo_specular_reflection_coef").val(), null, null);
	});
	// Ssadradius 설정
	$("#changeSsadRadiusButton").click(function() {
		changeSsadRadiusAPI($("#geo_ssao_radius").val());
	});

	// click poisition call back function
	function showClickPosition(position) {
		$("#positionLatitude").val(position.lat);
		$("#positionLongitude").val(position.lon);
		$("#positionAltitude").val(position.alt);
	}
</script>
</body>
</html>