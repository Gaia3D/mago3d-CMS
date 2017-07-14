<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<!-- <meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="-1"/>
	<meta http-equiv="Pragma" content="no-cache"/> -->
	<title>demo | mago3D User</title>
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<link rel="stylesheet" href="/css/${lang}/homepage-demo.css?currentTime=${currentTime}" />
	<link rel="stylesheet" href="/externlib/${lang}/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-toast/jquery.toast.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-toast/jquery.toast.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<div class="trigger" >
		<button type="button"></button>
		<ul>
			<li><a href="/homepage/index.do">Home</a></li>
			<li><a href="/homepage/about.do">Mago3D</a></li>	
			<li><a href="/homepage/download.do">Download</a></li>
			<li><a href="/homepage/tutorials.do">Tutorials</a></li>
		</ul>
	</div>
	<div class="ctrl">
		<div>
			<button id="issueEnable">Issue Report</button>
			<button id="objectInfoEnable">Object Info.</button>	
			<button id="issuesEnable">Issues Info.</button>
			<input type="hidden" id="now_latitude" name="now_latitude" value="${now_latitude }" />
			<input type="hidden" id="now_longitude" name="now_longitude" value="${now_longitude }"  />
		</div>
		<ul class="tab">
			<li id="issueMoreImage">My Issue</li>
			<li id="apiMoreImage">API List</li>
		</ul>
		<ul id="recentIssueListContent" class="issue" style="display: none">
<c:if test="${empty issueList }">
			<li style="text-align: center; padding-top:20px; height: 50px;">
				The issue does not exist.
			</li>
</c:if>
<c:if test="${!empty issueList }">
	<c:set var="issueTypeCss" value="i1" />
	<c:set var="issuePriorityCss" value="t1" />
	<c:forEach var="issue" items="${issueList}" varStatus="status">
		<c:if test="${issue.issue_type eq 'BUGGER'}">
			<c:set var="issueTypeCss" value="i1" />
		</c:if>
		<c:if test="${issue.issue_type eq 'IMPROVE'}">
			<c:set var="issueTypeCss" value="i2" />
		</c:if>
		<c:if test="${issue.issue_type eq 'NEW'}">
			<c:set var="issueTypeCss" value="i3" />
		</c:if>
		<c:if test="${issue.issue_type eq 'ETC'}">
			<c:set var="issueTypeCss" value="i4" />
		</c:if>
		<c:if test="${issue.priority eq 'CRITICAL'}">
			<c:set var="issuePriorityCss" value="t1" />
		</c:if>
		<c:if test="${issue.priority eq 'MUST'}">
			<c:set var="issuePriorityCss" value="t2" />
		</c:if>
		<c:if test="${issue.priority eq 'MINOR'}">
			<c:set var="issuePriorityCss" value="t3" />
		</c:if>
		<c:if test="${issue.priority eq 'TRIVIAL'}">
			<c:set var="issuePriorityCss" value="t4" />
		</c:if>
			<li>
				<p class="title">
					${issue.title }
				</p>
				<p class="info">
					<span class="tag ${issueTypeCss }">${issue.issue_type_name }</span>
					<span class="tag ${issuePriorityCss }">${issue.priority_name }</span>
					<span>[${issue.data_group_name }]</span>
					<button type="button" title="Shortcuts" onclick="flyTo('${issue.issue_id}', '${issue.issue_type}', '${issue.longitude}', '${issue.latitude}', '${issue.height}', '2')">바로가기</button>
					<span class="date">${issue.viewInsertDate }</span>
				</p>
			</li>
	</c:forEach>
</c:if>
		</ul>

		<div id="apiListContent" style="display: none">
			<div style="height: 20px;"></div>
			<div>
				<span style="padding-left: 10px; padding-right: 100px;">Data Key</span>
				<input type="text" id="search_data_key" name="search_data_key" size="15" />
				<button type="button" id="searchData" style="width: 50px; background: #727272; font-size: 1.2rem;">Search</button>
			</div>
			<div style="margin-top: 15px;">
				<span style="padding-left: 10px; padding-right: 70px;">Bounding Box</span>
				<input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBox(true);" />
				<label for="showBoundingBox"> Show </label>
				<input type="radio" id="hideBoundingBox" name="boundingBox" value="false" onclick="changeBoundingBox(false);"/>
				<label for="hideBoundingBox"> Hide </label>
			</div>
			<div style="margin-top: 15px;">
				<span style="padding-left: 10px; padding-right: 16px;">Selecting And Moving</span>
				<input type="radio" id="mouseAllMove" name="mouseMoveMode" value="0" onclick="changeMouseMove('0');"/>
				<label for="mouseAllMove"> ALL </label>
				<input type="radio" id="mouseObjectMove" name="mouseMoveMode" value="1" onclick="changeMouseMove('1');"/>
				<label for="mouseObjectMove"> Object </label>
			</div>
			<div style="margin-top: 15px;">
				<div style="padding-left: 10px;">
					Location And Rotation
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 60px; padding-right: 12px;">
						<label for="move_data_key">Data Key</label>
						<input type="text" id="move_data_key" name="move_data_key" size="15" />
					</span>
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 66px; padding-right: 12px;">
						<label for="move_latitude">Latitude</label>
						<input type="text" id="move_latitude" name="move_latitude" size="15"/> 
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 53px; padding-right: 12px;">
						<label for="move_longitude">Longitude</label>
						<input type="text" id="move_longitude" name="move_longitude" size="15"/>
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 66px; padding-right: 12px;">
						<label for="move_height">Altitude</label>
						<input type="text" id="move_height" name="move_height" size="15" />
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 63px; padding-right: 12px;">
						<label for="move_heading">Heading</label>
						<input type="text" id="move_heading" name="move_heading" size="15" />
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 66px; padding-right: 12px;">
						<label for="move_pitch">Pitch</label>
						<input type="text" id="move_pitch" name="move_pitch" size="15" />
					</span>
				</div> 
				<div style="margin-top: 5px;">
					<span style="padding-left: 66px; padding-right: 12px;">
						<label for="move_roll">Roll</label>
						<input type="text" id="move_roll" name="move_roll" size="15" /> 
						<button type="button" id="changeLocationAndRotationAPI">Transform</button>
					</span>
				</div>
			</div>
			<div style="height: 20px;"></div>
		</div>
	</div>
		
	<div class="shortcut" style="top:60px;">
		<p>Shortcuts</p>
		<ul>
<c:forEach var="dataGroup" items="${projectDataGroupList}" varStatus="status">
			<li onclick="flyTo(null, null, '${dataGroup.longitude}', '${dataGroup.latitude}', '${dataGroup.height}', '${dataGroup.duration}')">${dataGroup.data_group_name }</li>
</c:forEach>
		</ul>
	</div>	

	<!-- 맵영역 -->
	<div style="position: absolute; width: 100%; height: 100%; margin-top: 0; padding: 0; overflow: hidden;">
		<canvas id="magoContainer" style="width: 100%; height: 100%">
	        Your browser does not support HTML5 Canvas.
	    </canvas>
	</div>

	<form:form id="issue" modelAttribute="issue" method="post" onsubmit="return false;">
	<div id="inputIssueLayer" style="display: none; top:40%; left:45%; width:450px; margin:-250px 0 0 -150px; " class="layer">
	    <div class="layerHeader">
	        <h2>Issue Register</h2>
	        <div>
	            <button id="inputIssueClose" type="button" title="닫기">Close</button>
	        </div>
	    </div>
	    <div class="layerContents">
	        <table>
	        	<tr>
	        		<th style="width: 120px;">
	        			<form:label path="data_group_id">Data Group</form:label>
	        			<span class="icon-glyph glyph-emark-dot color-warning"></span>
	        		</th>
	        		<td>
	        			<form:select path="data_group_id" cssClass="select">
<c:forEach var="dataGroup" items="${projectDataGroupList}">
							<option value="${dataGroup.data_group_id}">${dataGroup.data_group_name_en}</option>
</c:forEach>
						</form:select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>
	        			<form:label path="issue_type">Issue Type</form:label>
	        		</th>
	        		<td>
	        			<form:select path="issue_type" cssClass="select">
<c:forEach var="commonCode" items="${issueTypeList}">
							<option value="${commonCode.code_value}">${commonCode.code_name_en}</option>
</c:forEach>
						</form:select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>
	        			<form:label path="data_key">Data Key</form:label>
	        			<span class="icon-glyph glyph-emark-dot color-warning"></span>
	        		</th>
	        		<td><form:input path="data_key" cssClass="ml" />
						<form:errors path="data_key" cssClass="error" />
						<form:hidden path="latitude"/>
						<form:hidden path="longitude"/>
						<form:hidden path="height"/>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>
	        			<form:label path="title">Title</form:label>
	        			<span class="icon-glyph glyph-emark-dot color-warning"></span>
	        		</th>
	        		<td><form:input path="title" cssClass="ml" />
						<form:errors path="title" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="priority">Issue Priority</form:label></th>
	        		<td>
	        			<form:select path="priority" cssClass="select">
<c:forEach var="commonCode" items="${issuePriorityList}">
							<option value="${commonCode.code_value}">${commonCode.code_name}</option>
</c:forEach>
						</form:select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="due_date">Due Date</form:label></th>
	        		<td><form:hidden path="start_date" />
						<input type="text" id="start_day" name="start_day" placeholder="Day" size="7" maxlength="4" />
						<input type="text" id="start_hour" name="start_hour" placeholder="Hour" size="3" maxlength="2" />
						<span class="delimeter">:</span>
						<input type="text" id="start_minute" name="start_minute" placeholder="Minute" size="3" maxlength="2" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="assignee">Assignee</form:label></th>
	        		<td><form:input path="assignee" cssClass="m" placeholder="assignee" />
						<form:errors path="assignee" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="reporter">reporter</form:label></th>
	        		<td><form:input path="reporter" cssClass="m" placeholder="reporter" />
						<form:errors path="reporter" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr style="height: 50px;">
	        		<th><form:label path="contents">Contents</form:label></th>
	        		<td>
	        			<form:textarea path="contents" />
						<form:errors path="contents" cssClass="error" />
	        		</td>
				</tr>
	        </table>
	        
	      	<div class="btns">
	 			<button id="issueInsertButton">Save</button>
			</div>
	    </div>
	</div>
	</form:form>

<script type="text/javascript" src="/externlib/${lang}/webworldwind/worldwind.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Code.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/API.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Config.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Callback.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Constant.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Message.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ManagerFactory.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Atmosphere.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeometryUtil.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeometryModifier.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Line.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Plane.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Point3D.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Shader.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ShaderSource.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ReaderWriter.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Renderer.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Selection.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VBOManager.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/CesiumManager.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/PostFxShader.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/FBO.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Geometry.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Accessor.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/NeoTexture.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/BoundingBox.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/BlockModels.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/FileRequestControler.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ManagerUtils.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/NeoReferenceModels.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/OcclusionCullOctree.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Octree.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VisibleObjectsControler.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Matrix4.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Lego.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Camera.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeoLocationData.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/MagoFacade.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Policy.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Box.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Vertex.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Triangle.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TriSurface.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TriPolyhedron.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VertexList.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VertexMatrix.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Color.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Quaternion.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/domain/ProjectLayer.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/MetaData.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/SceneState.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/SplitValue.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Frustum.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeographicCoord.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TerranTile.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GlobeTile.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Sphere.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ObjectMarker.js?currentTime=${currentTime}"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Pin.js?currentTime=${currentTime}"></script>
<script>
	var agent = navigator.userAgent.toLowerCase();
	if(agent.indexOf('chrome') < 0) { 
		alert("This page is optimized for the Chrome browser for massive data processing.\nPlease use the Chrome browser for seamless service.");
	}

	var policyJson = ${policyJson};
	var dataGroupMap = ${dataGroupMap};
	var insertIssueFlag = false;
	var objectInfoViewFlag = false;
	var listIssueFlag = false;
	var imagePath = "/images/${lang}";
	var managerFactory = new ManagerFactory(null, "magoContainer", policyJson, dataGroupMap, imagePath);
	
	$(document).ready(function() {
		//$("#recentIssueListContent").show();
		
		// BoundingBox
		changeBoundingBox(false);
		// Selecting And Moving
		changeMouseMove("0");
	});
	$("#issueMoreImage").click(function() {
		if($("#recentIssueListContent").css("display") == "none") {
			$("#issueMoreImage").addClass("on");
			$("#apiMoreImage").removeClass("on");
			$("#recentIssueListContent").show();
			$("#apiListContent").hide();
		} else {
			$("#issueMoreImage").removeClass("on");
			$("#recentIssueListContent").hide();
		}
	});
	$("#apiMoreImage").click(function() {
		if($("#apiListContent").css("display") == "none") {
			$("#apiMoreImage").addClass("on");
			$("#issueMoreImage").removeClass("on");
			$("#apiListContent").show();
			$("#recentIssueListContent").hide();
		} else {
			$("#apiMoreImage").removeClass("on");
			$("#apiListContent").hide();
		}
	});
	
	function flyTo(issueId, issueType, longitude, latitude, height, duration) {
		managerFactory.flyTo(issueId, issueType, longitude, latitude, height, duration);
		// 현재 좌표를 저장
		$("#now_latitude").val(latitude);
		$("#now_longitude").val(longitude);
	}
	
	// 이슈 등록
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
	// object info 표시
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
	// issue list 표시
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
		changeListIssueViewModeAPI(listIssueFlag);
	});
	
	// issue input layer call back function
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
		/* if ($("#assignee").val() == "") {
			alert(JS_MESSAGE["issue.assignee.empty"]);
			$("#assignee").focus();
			return false;
		}
		if ($("#reporter").val() == "") {
			alert(JS_MESSAGE["issue.reporter.empty"]);
			$("#reporter").focus();
			return false;
		} */
		if ($("#contents").val() == "") {
			alert(JS_MESSAGE["issue.contents.empty"]);
			$("#contents").focus();
			return false;
		}
		if ($("#start_hour").val() > 23) {
			alert(JS_MEESAGE["issue.start_hour.proper"]);
			$("#start_hour").focus();
			return false;
		}
		if ($("#start_minute").val() > 59) {
			alert(JS_MESSAGE["issue.start_minute.proper"]);
			$("#start_minute").focus();
			return false;
		}
	}
	
	var isInsertIssue = true;
	$("#issueInsertButton").click(function() {
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
					
					$("#inputIssueLayer").hide();
					isInsertIssue = true;
					ajaxIssueList();
				},
				error:function(request,status,error){
			        //alert(JS_MESSAGE["ajax.error.message"]);
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			        isInsertIssue = true;
				}
			});
			
			changeInsertIssueStateAPI(0);
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	
	$("#inputIssueClose").click(function() {
		$("#inputIssueLayer").hide();
		changeInsertIssueStateAPI(0);
	});
	
	// object 정보 표시 call back function
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
	
	// Data 검색
	$("#searchData").click(function() {
		if ($.trim($("#search_data_key").val()) === ""){
			alert("Please enter data key.");
			$("#search_data_key").focus();
			return false;
		}
		searchDataAPI($("#search_data_key").val());
	});
	// boundingBox 표시/비표시
	function changeBoundingBox(isShow) {
		$("input:radio[name='boundingBox']:radio[value='" + isShow + "']").prop("checked", true);
		changeBoundingBoxAPI(isShow);
	}
	// 마우스 클릭 객체 이동 모드 변경
	function changeMouseMove(mouseMoveMode) {
		$("input:radio[name='mouseMoveMode']:radio[value='" + mouseMoveMode + "']").prop("checked", true);
		changeMouseMoveAPI(mouseMoveMode);
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
					
					if(issueList == null || issueList.length == 0) {
						content += 	"<li style=\"text-align: center; padding-top:20px; height: 50px;\">"
								+	"	The issue does not exist."
								+	"</li>";
					} else {
						for(i=0; i<issueList.length; i++ ) {
							var issue = issueList[i];
							var issueTypeCss = "i1";
							var issuePriorityCss = "t1";
							if(issue.issue_type == "BUGGER") {
								issueTypeCss = "i1";
							} else if(issue.issue_type == "IMPROVE") {
								issueTypeCss = "i2";
							} else if(issue.issue_type == "NEW") {
								issueTypeCss = "i3";
							} else if(issue.issue_type == "ETC") {
								issueTypeCss = "i4";
							}
							
							if(issue.priority == "CRITICAL") {
								issuePriorityCss = "t1";
							} else if(issue.priority == "MUST") {
								issuePriorityCss = "t2";
							} else if(issue.priority == "MINOR") {
								issuePriorityCss = "t3";
							} else if(issue.priority == "TRIVIAL") {
								issuePriorityCss = "t4";
							}
							
							content = content 
								+ 	"<li>"
								+ 	"	<p class=\"title\">" + issue.title  + "</p>"
								+ 	"	<p class=\"info\">"
								+ 	"		<span class=\"tag " + issueTypeCss + "\">" + issue.issue_type_name + "</span>"
								+ 	"		<span class=\"tag " + issuePriorityCss + "\">" + issue.priority_name + "</span>"
								+ 	"		<span>[" + issue.data_group_name + "]</span>"
								+ 	"		<button type=\"button\" title=\"바로가기\""
								+				"onclick=\"flyTo('" + issue.issue_id + "', '" + issue.issue_type + "', '" 
								+ 				issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2')\">바로가기</button>"
								+ 	"		<span class=\"date\">" + issue.insert_date.substring(0,19) + "</span>"
								+	"	</p>"
								+ 	"</li>";
						}
					}
					$("#recentIssueListContent").empty();
					$("#recentIssueListContent").html(content);
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
</script>
</body>
</html>