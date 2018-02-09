<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
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
	<script type="text/javascript" src="/externlib/${lang}/hammer/hammer.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/js/${lang}/common.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/js/${lang}/message.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
	<style>
		input {height: 29px;}
		body, th, td, input, select, textarea { color:#444; font-family:'Malgun Gothic','돋움',dotum, sans-serif; font-size:12px; line-height:1.8em; }
	</style>
</head>
<body>
	<input type="hidden" id="now_latitude" name="now_latitude" value="${now_latitude }" />
	<input type="hidden" id="now_longitude" name="now_longitude" value="${now_longitude }"  />
<ul class="mobile-nav">
	<li id="homeMenu" class="home">
		<img src="/images/ko/homepage/home-icon.png" style="width: 35px; height: 35px; padding-right: 2px;"/>
	</li>
	<li id="shortCutMenu" class="shortCuts" data-tooltip-text="Provides a shortcut function.">Link</li>
	<li id="myIssueMenu" class="issue" data-tooltip-text="Shows the latest 10 issues sorted chronologically from the entire Issue List.">Issue
		<br /><span id="issueListCount">${totalCount }</span></li>
	<li id="searchMenu" class="search" data-tooltip-text="searching such as issue, object, and spatial information.">Search</li>
	<li id="apiMenu" class="api" data-tooltip-text="APIs to control various functions of mago3D.">API</li>	
	<li id="insertIssueMenu" class="regist" data-tooltip-text="Issue registration for Object.">Regist.</li>
	<li id="configMenu" class="config" data-tooltip-text="Settings related to rendering.">Settings</li>	
</ul>

<div id="menuContent" class="mobile-navContents">
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
	
	<ul id="shortCutMenuContent" class="shortList">
<c:forEach var="project" items="${projectList}" varStatus="status">
		<li class="shortCutbtn" 
			onclick="gotoProject('${project.project_id }', '${project.longitude}', '${project.latitude}', '${project.height}', '${project.duration}')">${project.project_name }</li>
</c:forEach>
	</ul>
	
	<ul id="myIssueMenuContent" class="issueList">
		<li style="margin-bottom: 8px; font-size: 1em; font-weight: normal; color: #2955a6;">Show up to 10 latest issues.</li>
<c:if test="${empty issueList }">
		<li style="text-align: center; padding-top: 20px; height: 50px;">Issues do not exist.</li>
</c:if>
<c:if test="${!empty issueList }">
	<c:forEach var="issue" items="${issueList}" varStatus="status">
		<li>
			<button class="issueBtn" type="button" title="Shortcuts" 
				onclick="gotoIssue('${issue.project_id}', '${issue.issue_id}', '${issue.issue_type}', '${issue.longitude}', '${issue.latitude}', '${issue.height}', '2')">Shortcuts</button>
			<div class="info">
				<p class="title">
					<span>${issue.project_name }</span>
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
				<td style="width: 380px;"><label for="project_id">Project</label></td>
				<td><select id="project_id" name="project_id" class="select">
						<option value=""> ALL </option>
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</select>
				</td>
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
				<td><label for="search_value">Word</label></td>
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
				<td><select id="order_word" style="width: 60px;" name="order_word" class="select">
						<option value=""> Basic </option>
						<option value="register_date"> Registration Date </option>
					</select> 
					<select id="order_value" style="width: 60px;" name="order_value" class="select">
						<option value=""> Basic </option>
						<option value="ASC"> Ascending </option>
						<option value="DESC"> Descending </option>
					</select> 
					<select id="list_counter" style="width: 80px;" name="list_counter" class="select">
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
			<h3>Local(Browser) Search</h3>
			<ul class="apiLoca">
				<li>
					<label for="localSearchProjectId">Project </label>
					<select id="localSearchProjectId" name="localSearchProjectId" class="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</select>
				</li>
				<li>
					<label for="localSearchDataKey">Data Key</label>
					<input type="text" id="localSearchDataKey" name="localSearchDataKey" size="15" />
					<button type="button" id="localSearch" class="btn">Search</button> 
				</li>
			</ul>
		</div>
		<div>
			<h3>Property Rendering</h3>
			<ul class="apiLoca">
				<li>
					<input type="radio" id="showPropertyRendering" name="propertyRendering" value="true" />
					<label for="showLabel"> Show </label>
					<input type="radio" id="hidePropertyRendering" name="propertyRendering" value="false" />
					<label for="hideLabel"> Hide </label>
				</li>
				<li>
					<label for="propertyRenderingProjectId">Project </label>
					<select id="propertyRenderingProjectId" name="propertyRenderingProjectId" class="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</select>
				</li>
				<li>
					<label for="propertyRenderingWord">Property</label>
					<input type="text" id="propertyRenderingWord" name="propertyRenderingWord" size="15" placeholder="isMain=true" />
					<button type="button" id="changePropertyRendering" class="btn">Change</button> 
				</li>
			</ul>
		</div>
		<div>
			<h3>Color Change</h3>
			<ul class="apiLoca">
				<li>
					<label for="colorProjectId">Project </label>
					<select id="colorProjectId" name="colorProjectId" class="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</select>
				</li>
				<li>
					<label for="colorDataKey">Data Key</label>
					<input type="text" id="colorDataKey" name="colorDataKey" size="15" />
				</li>
				<li>
					<label for="colorObjectIds">Object Id</label>
					<input type="text" id="colorObjectIds" name="colorObjectIds" placeholder="   , Delimiter" size="15" />
				</li>
				<li>
					<label for="colorProperty">Property</label>
					<input type="text" id="colorProperty" name="colorProperty" size="15" placeholder="isMain=true" />
				</li>
				<li>
					<label for="updateColor">Color</label>
					<select id="updateColor" name="updateColor" class="select">
						<option value="255,0,0"> Red </option>
						<option value="255,255,0"> Yellow </option>
						<option value="0,255,0"> Green </option>
						<option value="0,0,255"> Blue </option>
						<option value="255,0,255"> Pink </option>
						<option value="0,0,0"> Black </option>
					</select>
					<button type="button" id="changeColor" class="btn">Change</button> 
					<button type="button" id="deleteAllChangeColor" class="btn">All Delete</button>
				</li>
			</ul>
		</div>
		<div>
			<h3>Location and Rotation</h3>
			<ul class="apiLoca">
				<li>
					<label for="moveProjectId">Project </label>
					<select id="moveProjectId" name="moveProjectId" class="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</select>
				</li>
				<li>
					<label for="moveDataKey">Data Key</label> 
					<input type="text" id="moveDataKey" name="moveDataKey" size="15" />
				</li>
				<li>
					<label for="moveLatitude">Latitude </label> 
					<input type="text" id="moveLatitude" name="moveLatitude" size="15" />
				</li>
				<li>
					<label for="moveLongitude">Longitude </label> 
					<input type="text" id="moveLongitude" name="moveLongitude" size="15" />
				</li>
				<li>
					<label for="moveHeight">Altitude </label> 
					<input type="text" id="moveHeight" name="moveHeight" size="15" />
				</li>
				<li>
					<label for="moveHeading">Heading </label> 
					<input type="text" id="moveHeading" name="moveHeading" size="15" />
				</li>
				<li>
					<label for="movePitch">Pitch </label> 
					<input type="text" id="movePitch" name="movePitch" size="15" />
				</li>
				<li>
					<label for="moveRoll">Roll </label> 
					<input type="text" id="moveRoll" name="moveRoll" size="15" />
					<button type="button" id="changeLocationAndRotation" class="btn">Transform</button>
				</li>
			</ul>
		</div>
		<div>
			<h3>Issues Lists(100) near current location</h3>
			<input type="radio" id="showNearGeoIssueList" name="nearGeoIssueList" value="true" onclick="changeNearGeoIssueList(true);" /> 
			<label for="showNearGeoIssueList"> Show </label> 
			<input type="radio" id="hideNearGeoIssueList" name="nearGeoIssueList" value="false" onclick="changeNearGeoIssueList(false);" /> 
			<label for="hideNearGeoIssueList"> Hide </label>
		</div>
		<div>
			<h3>About the location of the click point</h3>
			<ul class="apiLoca">
				<li>
					<label for="positionLatitude"> Latitude </label>
					<input type="text" id="positionLatitude" name="positionLatitude" size="15" />
				</li>
				<li>
					<label for="positionLongitude"> Longitude </label>
					<input type="text" id="positionLongitude" name="positionLongitude" size="15" />
				</li>
				<li>
					<label for="positionAltitude"> Altitude </label>
					<input type="text" id="positionAltitude" name="positionAltitude" size="15" />
				</li>
			</ul>
		</div>
	</div>

	<form:form id="issue" modelAttribute="issue" method="post" onsubmit="return false;">
		<div id="insertIssueMenuContent" class="insertIssueWrap">
			<table>
				<tr style="height: 35px;">
					<td style="width: 100px;" nowrap="nowrap">
						<form:label path="project_id">Project</form:label> 
						<span class="icon-glyph glyph-emark-dot color-warning"></span></td>
					<td><form:select path="project_id" cssClass="select">
<c:forEach var="project" items="${projectList}">
							<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
						</form:select></td>
				</tr>
				<tr style="height: 35px;">
					<td><form:label path="issue_type">Type</form:label> 
						<span class="icon-glyph glyph-emark-dot color-warning"></span></td>
					<td><form:select path="issue_type" cssClass="select">
<c:forEach var="commonCode" items="${issueTypeList}">
							<option value="${commonCode.code_key}">${commonCode.code_name}</option>
</c:forEach>
						</form:select></td>
				</tr>
				<tr style="height: 35px;">
					<td>Issue Location</td>
					<td>
						<button type="button" id="insertIssueEnableButton" class="btn">Please select object afer click</button>
					</td>
				</tr>
				<tr style="height: 35px;">
					<td><form:label path="data_key">Data Name</form:label> 
						<span class="icon-glyph glyph-emark-dot color-warning"></span></td>
					<td><form:input path="data_key" readonly="true" size="25" cssStyle="background-color: #CBCBCB;" /> 
						<form:errors path="data_key" cssClass="error" /> 
						<form:hidden path="object_key" /> 
						<form:hidden path="height" /></td>
				</tr>
				<tr style="height: 35px;">
					<td><form:label path="latitude">Latitude</form:label> 
						<span class="icon-glyph glyph-emark-dot color-warning"></span></td>
					<td><form:input path="latitude" readonly="true" size="25" cssStyle="background-color: #CBCBCB;" /> 
						<form:errors path="latitude" cssClass="error" /></td>
				</tr>
				<tr style="height: 35px;">
					<td><form:label path="longitude">Longitude</form:label> 
						<span class="icon-glyph glyph-emark-dot color-warning"></span></td>
					<td><form:input path="longitude" readonly="true" size="25" cssStyle="background-color: #CBCBCB;" /> 
						<form:errors path="longitude" cssClass="error" /></td>
				</tr>
				<tr style="height: 60px;">
					<td><form:label path="title">Title</form:label> 
						<span class="icon-glyph glyph-emark-dot color-warning"></span></td>
					<td><form:textarea path="title" rows="2" cols="32" /> 
						<form:errors path="title" cssClass="error" /></td>
				</tr>

				<tr style="height: 35px;">
					<td><form:label path="priority">Priority</form:label> 
						<span class="icon-glyph glyph-emark-dot color-warning"></span></td>
					<td><form:select path="priority" cssClass="select">
<c:forEach var="commonCode" items="${issuePriorityList}">
								<option value="${commonCode.code_key}">${commonCode.code_name}</option>
</c:forEach>
						</form:select></td>
				</tr>

				<tr style="height: 35px;">
					<td><form:label path="due_day">Due Date</form:label></td>
					<td><form:hidden path="due_date" /> 
						<input type="text" id="due_day" name="due_day" class="date" size="10" maxlength="10" /> 
						D <input type="text" id="due_hour" name="due_hour" placeholder=" 00" size="2" maxlength="2" style="width: 30px;" /> : 
						<input type="text" id="due_minute" name="due_minute" placeholder=" 00" size="2" maxlength="2" style="width: 30px;"/> 
						M
					</td>
				</tr>

				<tr style="height: 35px;">
					<td><form:label path="assignee">Assignee</form:label></td>
					<td><form:input path="assignee" cssClass="m" placeholder=" assignee" size="24" style="width: 147px"/>
						<button type="button" class="btn" onclick="alert('Comming soon.');">Select</button> 
						<form:errors path="assignee" cssClass="error" /></td>
				</tr>

				<tr style="height: 35px;">
					<td><form:label path="reporter">reporter</form:label></td>
					<td><form:input path="reporter" cssClass="m" placeholder=" reporter" size="24" style="width: 147px"/>
						<button type="button" class="btn" onclick="alert('Comming soon.');">Select</button> 
						<form:errors path="reporter" cssClass="error" /></td>
				</tr>

				<tr>
					<td><form:label path="contents">Contents</form:label> 
						<span class="icon-glyph glyph-emark-dot color-warning"></span></td>
					<td><form:textarea path="contents" rows="5" cols="32"/> 
						<form:errors path="contents" cssClass="error" /></td>
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
			<label for="showObjectInfo"> 표시 </label> 
			<input type="radio" id="hideObjectInfo" name="objectInfo" value="false" onclick="changeObjectInfoViewMode(false);" /> 
			<label for="hideObjectInfo"> 비표시 </label>
		</div>
		<div>
			<h3>Bounding Box</h3>
			<input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBox(true);" /> 
			<label for="showBoundingBox"> Show </label> 
			<input type="radio" id="hideBoundingBox" name="boundingBox" value="false" onclick="changeBoundingBox(false);" /> 
			<label for="hideBoundingBox"> Hide </label>
		</div>
		<div>
			<h3>Selecting And Moving</h3>
			<input type="radio" id="objectNoneMove" name="objectMoveMode" value="2" onclick="changeObjectMove('2');"/>
			<label for="objectNoneMove"> None </label>
			<input type="radio" id="objectAllMove" name="objectMoveMode" value="0" onclick="changeObjectMove('0');"/>
			<label for="objectAllMove"> ALL </label>
			<input type="radio" id="objectMove" name="objectMoveMode" value="1" onclick="changeObjectMove('1');"/>
			<label for="objectMove"> Object </label>
			
			<button type="button" id="saveObjectMoveButton" class="btn">Save</button>
			<button type="button" id="deleteAllObjectMoveButton" class="btn">All Delete</button>
		</div>
		
		<div>
			<h3>Object Occlusion Culling</h3>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">Select</div>
				<input type="radio" id="useOcclusionCulling" name="occlusionCulling" value="true" />
				<label for="useOcclusionCulling"> use </label>
				<input type="radio" id="unusedOcclusionCulling" name="occlusionCulling" value="false" />
				<label for="unusedOcclusionCulling"> unused </label>
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">Data Key</div>
				<input type="text" id="occlusion_culling_data_key" name="occlusion_culling_data_key" size="15" />
				<button type="button" id="changeOcclusionCullingButton" class="btn">변경</button>
			</div>
		</div>
		<div>
			<h3>LOD</h3>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">LOD0</div>
				<input type="text" id="geo_lod0" name="geo_lod0" value="${policy.geo_lod0 }" size="15" />&nbsp;M
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">LOD1</div>
				<input type="text" id="geo_lod1" name="geo_lod1" value="${policy.geo_lod1 }" size="15" />&nbsp;M
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">LOD2</div>
				<input type="text" id="geo_lod2" name="geo_lod2" value="${policy.geo_lod2 }" size="15" />&nbsp;M
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">LOD3</div>
				<input type="text" id="geo_lod3" name="geo_lod3" value="${policy.geo_lod3 }" size="15" />&nbsp;M
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">LOD4</div>
				<input type="text" id="geo_lod4" name="geo_lod4" value="${policy.geo_lod4 }" size="15" />&nbsp;M
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;">LOD5</div>
				<input type="text" id="geo_lod5" name="geo_lod5" value="${policy.geo_lod5 }" size="15" />&nbsp;M&nbsp;&nbsp;
				<button type="button" id="changeLodButton" class="btn">Change</button>
			</div>
		</div>
		<div>
			<h3>Lighting</h3>
			<div style="height: 30px;">AmbientReflectionCoeficient</div>
			<div id="ambient_reflection_coef" style="display: inline-block; width: 279px;">
				<div id="geo_ambient_reflection_coef_view" class="ui-slider-handle"></div>
				<input type="hidden" id="geo_ambient_reflection_coef" name="geo_ambient_reflection_coef" value="0.5" />
			</div>
			<div style="height: 30px;">DiffuseReflectionCoeficient</div>
			<div id="diffuse_reflection_coef" style="display: inline-block; width: 279px;">
				<div id="geo_diffuse_reflection_coef_view" class="ui-slider-handle"></div>
				<input type="hidden" id="geo_diffuse_reflection_coef" name="geo_diffuse_reflection_coef" value="1" />
			</div>
			<div style="height: 30px;">SpecularReflectionCoeficient</div>
			<div id="specular_reflection_coef" style="display: inline-block; width: 279px;">
				<div id="geo_specular_reflection_coef_view" class="ui-slider-handle"></div>
				<input type="hidden" id="geo_specular_reflection_coef" name="geo_specular_reflection_coef" value="1" />
			</div>
			<div style="height: 30px; text-align: center;">
				<button type="button" id="changeLightingButton" class="btn">Change</button>
			</div>
			
			<div style="text-align: center">
			</div>
		</div>
		<div>
			<h3><label for="geo_ssao_radius">SSAO Radius</label></h3>
			<input type="text" id="geo_ssao_radius" name="geo_ssao_radius" />
			<button type="button" id="changeSsaoRadiusButton" class="btn">Change</button>
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
	
	var managerFactory = null;
	var policyJson = ${policyJson};
	var initProjectJsonMap = ${initProjectJsonMap};
	var menuMap = new Map();
	menuMap.set("homeMenu", false);
	menuMap.set("shortCutMenu", false);
	menuMap.set("myIssueMenu", false);
	menuMap.set("searchMenu", false);
	menuMap.set("apiMenu", false);
	menuMap.set("insertIssueMenu", false);
	menuMap.set("configMenu", false);
	var insertIssueEnable = false;
	var FPVModeFlag = false;
	
	var imagePath = "/images/${lang}";
	var dataInformationUrl = "/data/ajax-project-data-by-project-id.do";
	magoStart();
	var intervalCount = 0;
	var timerId = setInterval("startMogoUI()", 1000);
	
	$(document).ready(function() {
	});
	
	function startMogoUI() {
		intervalCount++;
		if(managerFactory != null && managerFactory.getMagoManagerState() === CODE.magoManagerState.READY) {
			initJqueryCalendar();
			// Label 표시
			changeLabel(false);
			// object 정보 표시
			changeObjectInfoViewMode(false);
			// BoundingBox
			changeBoundingBox(false);
			// Selecting And Moving
			changeObjectMove("2");
			// slider, color-picker
			initRendering();
			// 3PView Mode
			changeViewMode(false);
			
			clearInterval(timerId);
			console.log(" managerFactory != null, managerFactory.getMagoManagerState() = " + managerFactory.getMagoManagerState() + ", intervalCount = " + intervalCount);
			return;
		}
		console.log("--------- intervalCount = " + intervalCount);
	}
	
	// mago3d 시작, 정책 데이터 파일을 로딩
	function magoStart() {
		var initProjectsLength = ${initProjectsLength};
		if(initProjectsLength === null || initProjectsLength === 0) {
			managerFactory = new ManagerFactory(null, "magoContainer", policyJson, null, null, null, imagePath);
		} else {
			var projectIdArray = new Array(initProjectsLength);
			var projectDataArray = new Array(initProjectsLength);
			var projectDataFolderArray = new Array(initProjectsLength);
			var index = 0;
			for(var projectId in initProjectJsonMap) {
				projectIdArray[index] = projectId;
				var projectJson = JSON.parse(initProjectJsonMap[projectId]);
				projectDataArray[index] = projectJson;
				projectDataFolderArray[index] = projectJson.data_key;
				index++;
			}
			
			managerFactory = new ManagerFactory(null, "magoContainer", policyJson, projectIdArray, projectDataArray, projectDataFolderArray, imagePath);			
		}
	}
	
	// 프로젝트를 로딩한 후 이동
	function gotoProject(projectId, longitude, latitude, height, duration) {
		var projectData = getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
		if (projectData === null || projectData === undefined) {
			ajaxCall(dataInformationUrl, "project_id=" + projectId, gotoProjectCallback, errorCallback, null, projectId, longitude, latitude, height, duration);
		} else {
			gotoProjectAPI(managerFactory, projectId, projectData, projectData.data_key, longitude, latitude, height, duration);	
		}
		
		// 현재 좌표를 저장
		saveCurrentLocation(latitude, longitude);
	}
	function gotoProjectCallback(msg, theArgs) {
		if(msg.result == "success") {
			var projectDataJson = JSON.parse(msg.projectDataJson);
			if(projectDataJson === null || projectDataJson === undefined) {
				alert("Project data does not exist.");
				return;
			}
			gotoProjectAPI(managerFactory, theArgs[0], projectDataJson, projectDataJson.data_key, theArgs[1], theArgs[2], theArgs[3], theArgs[4]);
		} else {
			alert(JS_MESSAGE[msg.result]);
		}
	}
	
	// 이슈 위치로 이동
	function gotoIssue(projectId, issueId, issueType, longitude, latitude, height, duration) {
		var projectData = getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
		if (projectData === null || projectData === undefined) {
			ajaxCall(dataInformationUrl, "project_id=" + projectId, gotoIssueCallback, errorCallback, null, projectId, issueId, issueType, longitude, latitude, height, duration);
		} else {
			gotoIssueAPI(managerFactory, projectId, projectData, projectData.data_key, issueId, issueType, longitude, latitude, height, duration);	
		}
		
		// 현재 좌표를 저장
		saveCurrentLocation(latitude, longitude);
	}
	function gotoIssueCallback(msg, theArgs) {
		if(msg.result == "success") {
			var projectDataJson = JSON.parse(msg.projectDataJson);
			if(projectDataJson === null || projectDataJson === undefined) {
				alert("Project data does not exist.");
				return;
			}
			gotoIssueAPI(managerFactory, theArgs[0], projectDataJson, projectDataJson.data_key, theArgs[1], theArgs[2], theArgs[3], theArgs[4], theArgs[5], theArgs[6]);
		} else {
			alert(JS_MESSAGE[msg.result]);
		}
	}
	
	var swipe = new Hammer(document);
	// detect swipe and call to a function
	swipe.on('swiperight swipeleft', function(e) {
		e.preventDefault();
		if (e.type == 'swiperight') {
			// open menu
	    	$('.mobile-nav').animate({
	      		left: '0'
			});
		} else {
			// close/hide menu
			$('.mobile-nav').animate({
				left: '-100%'
			});
		}
	});
	
	//	Close
	$(".issueBtn").click(function (){
		CloseMenuContent(".issue");
	});
	$(".shortCutbtn").click(function (){
		CloseMenuContent(".shortCuts");
	});
	$("#mode1PV").click(function () {
		CloseMenuContent(".config");
	});
		$("#mode3PV").click(function () {
			CloseMenuContent(".config");
		});
	
	function CloseMenuContent(className) {
		$("#menuContent").hide();
		$(className).removeClass("on");
	}
	
	// issue 위치 버튼을 클릭 했을 경우
	$("#insertIssueEnableButton").click(function() {
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
	
	// issue input layer call back function
	function showInsertIssueLayer(data_key, object_key, latitude, longitude, height) {
		if(insertIssueEnable) {
			$("#data_key").val(data_key);
			$("#object_key").val(object_key);
			$("#latitude").val(latitude);
			$("#longitude").val(longitude);
			$("#height").val(height);
			
			// 현재 좌표를 저장
			saveCurrentLocation(latitude, longitude);
		}
	}
	
	// 이슈 등록
	var isInsertIssue = { "enable" : true };
	$("#issueSaveButton").click(function() {
		if (check() == false) {
			return false;
		}
		if(isInsertIssue["enable"]) {
			isInsertIssue["enable"] = false;
			var url = "/issue/ajax-insert-issue.do";
			var info = $("#issue").serialize();
			ajaxCall(url, info, issueSaveCallback, errorCallback, isInsertIssue);
			
			// issue 등록 버튼, css, 상태를 변경
			$("#insertIssueEnableButton").removeClass("on");
			$("#insertIssueEnableButton").text("Please select object after clicking.");
			insertIssueEnable = false;
			
			changeInsertIssueStateAPI(managerFactory, 0);
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	function issueSaveCallback(msg, theArgs) {
		if(msg.result == "success") {
			alert(JS_MESSAGE["insert"]);
			// pin image를 그림
			drawInsertIssueImageAPI(managerFactory, 1, msg.issue.issue_id, msg.issue.issue_type, 
					$("#data_key").val(), $("#latitude").val(), $("#longitude").val(), $("#height").val());
		} else {
			alert(JS_MESSAGE[msg.result]);
		}
		
		isInsertIssue["enable"] = true;
		ajaxIssueList();
	}
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
		var url = "/homepage/ajax-list-issue.do";
		ajaxCall(url, info, ajaxIssueListCallback, errorCallback, null);
	}
	function ajaxIssueListCallback(msg, theArgs) {
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
						+			"onclick=\"gotoIssue('" + issue.project_id + "', '" + issue.issue_id + "', '" + issue.issue_type + "', '" 
						+ 				issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2')\">Shortcuts</button>"
						+ 	"	<div class=\"info\">"
						+ 	"		<p class=\"title\">"
						+ 	"			<span>" + issue.project_name + "</span>"
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
	}
	
	// 왼쪽 메뉴 클릭시 ui 처리
	$("#homeMenu").click(function() {
		menuSlideControl("homeMenu");
	});
	$("#shortCutMenu").click(function() {
		menuSlideControl("shortCutMenu");
	})
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
		changeInsertIssueStateAPI(managerFactory, 0);
	});
	
	// 검색 메뉴 시작
	// Data 검색
	var searchDataFlag = { "enable" : true }
	$("#searchData").click(function() {
		if ($.trim($("#search_value").val()) === ""){
			alert("Please enter a search word.");
			$("#search_value").focus();
			return false;
		}
		
		if(searchDataFlag["enable"]) {
			searchDataFlag["enable"] = false;
			var info = $("#searchForm").serialize();
			var url = null;
			if($("#search_word").val() === "data_name") {
				url = "/data/ajax-search-data.do";
			} else {
				url = "/homepage/ajax-list-issue.do";
			}
			ajaxCall(url, info, searchDataCallback, errorCallback, searchDataFlag);
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	function searchDataCallback(msg, theArgs) {
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
							+ 	"<li>";
						if(dataInfo.parent !== 0) {	
							content = content 
							+ 	"	<button type=\"button\" title=\"Shortcuts\""
							+ 	" 		onclick=\"gotoData('" + dataInfo.project_id + "', '" + dataInfo.data_key + "');\">Shortcuts</button>";
						}
						content = content 
							+ 	"	<div class=\"info\">"
							+ 	"		<p class=\"title\">"
							+ 	"			<span>" + dataInfo.project_name + "</span>"
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
							+			" onclick=\"gotoIssue('" + issue.project_id + "', '" + issue.issue_id + "', '" + issue.issue_type + "', '" 
							+ 				issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2');\">Shortcuts</button>"
							+ 	"	<div class=\"info\">"
							+ 	"		<p class=\"title\">"
							+ 	"			<span>" + issue.project_name + "</span>"
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
	}
	
	// 데이터 위치로 이동
	function gotoData(projectId, dataKey) {
		searchDataAPI(managerFactory, projectId, dataKey);
	}
	
	$("#localSearch").click(function() {
		if ($.trim($("#localSearchDataKey").val()) === ""){
			alert("Please enter data key.");
			$("#localSearchDataKey").focus();
			return false;
		}
		searchDataAPI(managerFactory, $("#localSearchProjectId").val(), $("#localSearchDataKey").val());
	});
	
	// API 메뉴시작
	// object 정보 표시 call back function
	function showSelectedObject(dataKey, objectId, latitude, longitude, height, heading, pitch, roll) {
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
			saveCurrentLocation(latitude, longitude);
		}
	}
	
	// 속성 가시화
	$("#changePropertyRendering").click(function(e) {
		var isShow = $(':radio[name="propertyRendering"]:checked').val();
		if(isShow === undefined){
			alert("Select Show / Hide.");
			return false;
		}
		if ($.trim($("#propertyRenderingWord").val()) === ""){
			alert("Please enter property.");
			$("#propertyRenderingWord").focus();
			return false;
		}
		changePropertyRenderingAPI(managerFactory, isShow, $("#propertyRenderingProjectId").val(), $("#propertyRenderingWord").val());
	});
	
	// 색변경
	$("#changeColor").click(function(e) {
		if ($.trim($("#colorDataKey").val()) === ""){
			alert("Please enter data key.");
			$("#colorDataKey").focus();
			return false;
		}
		
		var objectIds = null;
		var colorObjectIds = $("#colorObjectIds").val();
		if(colorObjectIds !== null && colorObjectIds !=="") objectIds = colorObjectIds.split(",");
		changeColorAPI(managerFactory, $("#colorProjectId").val(), $("#colorDataKey").val(), objectIds, $("#colorProperty").val(), $("#updateColor").val());
	});
	// 색깔 변경 이력 삭제
	$("#deleteAllChangeColor").click(function () {
		if(confirm("Are you sure you want to delete?")) {
			deleteAllChangeColorAPI(managerFactory);
		}
	});
	
	// 변환행렬
	$("#changeLocationAndRotation").click(function() {
		if(!changeLocationAndRotationCheck()) return false;
		changeLocationAndRotationAPI(	managerFactory, $("#moveProjectId").val(),
										$("#moveDataKey").val(), $("#moveLatitude").val(), $("#moveLongitude").val(), 
										$("#moveHeight").val(), $("#moveHeading").val(), $("#movePitch").val(), $("#moveRoll").val());
	});
	function changeLocationAndRotationCheck() {
		if ($.trim($("#moveDataKey").val()) === ""){
			alert("Please enter data key.");
			$("#moveDataKey").focus();
			return false;
		}
		if ($.trim($("#moveLatitude").val()) === ""){
			alert("Please enter latitude.");
			$("#moveLatitude").focus();
			return false;
		}
		if ($.trim($("#moveLongitude").val()) === ""){
			alert("Please enter longitude.");
			$("#moveLongitude").focus();
			return false;
		}
		if ($.trim($("#moveHeight").val()) === ""){
			alert("Please enter height.");
			$("#moveHeight").focus();
			return false;
		}
		if ($.trim($("#moveHeading").val()) === ""){
			alert("Please enter heading.");
			$("#moveHeading").focus();
			return false;
		}
		if ($.trim($("#movePitch").val()) === ""){
			alert("Please enter pitch.");
			$("#movePitch").focus();
			return false;
		}
		if ($.trim($("#moveRoll").val()) === ""){
			alert("Please enter roll.");
			$("#moveRoll").focus();
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
			var url = "/issue/ajax-list-issue-by-geo.do";
			ajaxCall(url, info, changeNearGeoIssueListCallback, errorCallback, searchDataFlag);
		}
		changeNearGeoIssueListViewModeAPI(managerFactory, isShow);
	}
	function changeNearGeoIssueListCallback(msg, theArgs) {
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
	}
	
	// 설정 메뉴 시작
	// Label 표시
	function changeLabel(isShow) {
		$("input:radio[name='labelInfo']:radio[value='" + isShow + "']").prop("checked", true);
		changeLabelAPI(managerFactory, isShow);
	}
	// object info 표시
	function changeObjectInfoViewMode(isShow) {
		$("input:radio[name='objectInfo']:radio[value='" + isShow + "']").prop("checked", true);
		changeObjectInfoViewModeAPI(managerFactory, isShow);
	}
	// boundingBox 표시/비표시
	function changeBoundingBox(isShow) {
		$("input:radio[name='boundingBox']:radio[value='" + isShow + "']").prop("checked", true);
		changeBoundingBoxAPI(managerFactory, isShow);
	}
	// 마우스 클릭 객체 이동 모드 변경
	function changeObjectMove(objectMoveMode) {
		$("input:radio[name='objectMoveMode']:radio[value='" + objectMoveMode + "']").prop("checked", true);
		changeObjectMoveAPI(managerFactory, objectMoveMode);
	}
	// 마우스 클릭 객체 이동 모드 변경 저장
	$("#saveObjectMoveButton").click(function () {
		alert("준비중 입니다.");
		return;
		var objectMoveMode = $(':radio[name="objectMoveMode"]:checked').val();
		if(objectMoveMode === "2") {
			alert("Can not be saved in None mode.");
			return;
		}
		saveObjectMoveAPI(managerFactory, objectMoveMode);
	});
	// 마우스 클릭 객체 이동 모드 변경 삭제
	$("#deleteAllObjectMoveButton").click(function () {
		var objectMoveMode = $(':radio[name="objectMoveMode"]:checked').val();
		if(confirm("삭제 하시겠습니까?")) {
			deleteAllObjectMoveAPI(managerFactory, objectMoveMode);
		}
	});
	// Object Occlusion culling
	$("#changeOcclusionCullingButton").click(function () {
		changeOcclusionCullingAPI(managerFactory, ($(':radio[name="occlusionCulling"]:checked').val() === "true"), $("#occlusion_culling_data_key").val());		
	});
	// 카메라 모드 전환
	function changeViewMode(isFPVMode) {
		$("input:radio[name='viewMode']:radio[value='" + isFPVMode + "']").prop("checked", true);
		changeFPVModeAPI(managerFactory, isFPVMode);
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
	}
	
	// LOD 설정
	$("#changeLodButton").click(function() {
		changeLodAPI(managerFactory, $("#geo_lod0").val(), $("#geo_lod1").val(), $("#geo_lod2").val(), null);
	});
	// Lighting 설정
	$("#changeLightingButton").click(function() {
		changeLightingAPI(managerFactory, $("#geo_ambient_reflection_coef").val(), $("#geo_diffuse_reflection_coef").val(), $("#geo_specular_reflection_coef").val(), null, null);
	});
	// Ssadradius 설정
	$("#changeSsaoRadiusButton").click(function() {
		changeSsaoRadiusAPI(managerFactory, $("#geo_ssao_radius").val());
	});
	
	// click poisition call back function
	function showClickPosition(position) {
		$("#positionLatitude").val(position.lat);
		$("#positionLongitude").val(position.lon);
		$("#positionAltitude").val(position.alt);
	}
	
	// 모든 데이터 비표시
	function clearAllData() {
		clearAllDataAPI(managerFactory);
	}
	
	// general callback alert function
	function showApiResult(apiName, result) {
		if(apiName === "searchData") {
			if(result === "-1") {
				alert(" Information that has not yet been loaded. Please search after loading. ");
			}
		}
	}
	
	function saveCurrentLocation(latitude, longitude) {
		// 현재 좌표를 저장
		$("#now_latitude").val(latitude);
		$("#now_longitude").val(longitude);
	}
</script>
</body>
</html>