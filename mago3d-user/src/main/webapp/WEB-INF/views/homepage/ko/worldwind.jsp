<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>demo | mago3D User</title>
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<link rel="stylesheet" href="/css/${lang}/homepage-demo.css" />
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
	<div class="ctrl">
		<div>
			<button id="issueEnable">Issue 등록</button>
			<button id="objectInfoEnable">Object 정보</button>	
			<button id="issuesEnable">Issues 정보</button>
		</div>
		<ul>
			<li id="issueMoreImage">My Issue</li>
			<li id="apiMoreImage">API목록</li>
		</ul>
		<div id="recentIssueListContent" style="display: none">
<c:if test="${empty issueList }">
			<div style="text-align: center; padding-top:20px; height: 50px;">
				Issue가 존재하지 않습니다.
			</div>
</c:if>
<c:if test="${!empty issueList }">
	<c:forEach var="issue" items="${issueList}" varStatus="status">	
			<div style="padding-left: 20px; padding-top: 20px; padding-bottom: 20px; background: gainsboro">
				<div>
					<img src="/images/${lang }/homepage/bullet_h4.png" alt="" />
					<span style="padding-left: 10px; width:200px; overflow: hidden;">${issue.title }</span>
					<span style="float:right; padding-right: 15px; padding-top: 5px;">
						<a href="#" onclick="flyTo('${issue.longitude}', '${issue.latitude}', '${issue.height}', '2')">
							<img src="/images/${lang }/homepage/btn_going.png" width="26" height="26" alt="" />
						</a>
					</span>
				</div>
				<div id="issue_toggle_${issue.issue_id }">
					<span style="padding-left: 25px;">[${issue.issue_type }][${issue.priority }]</span>
					<span style="padding-left: 5px;">${issue.data_group_name }</span>
					<span style="float:right; padding-right: 20px;">${issue.viewInsertDate }</span>
				</div>
			</div>
	</c:forEach>
</c:if>
		</div>
		
		<div id="apiListContent" style="display: none">
			<div style="height: 20px;"></div>
			<div>
				<span style="padding-left: 10px; padding-right: 100px;">Data Key</span>
				<input type="text" id="search_data_key" name="search_data_key" size="15" />
				<button type="button" id="searchData" style="width: 50px; background: #727272; font-size: 1.2rem;">검색</button>
			</div>
			<div style="margin-top: 15px;">
				<span style="padding-left: 10px; padding-right: 70px;">Bounding Box</span>
				<input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBox(true);" />
				<label for="showBoundingBox"> 표시 </label>
				<input type="radio" id="hideBoundingBox" name="boundingBox" value="false" onclick="changeBoundingBox(false);"/>
				<label for="hideBoundingBox"> 비표시 </label>
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
					<span style="padding-left: 102px; padding-right: 12px;">
						<label for="move_data_key">Data Key</label>
						<input type="text" id="move_data_key" name="move_data_key" size="15" />
					</span>
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 110px; padding-right: 12px;">
						<label for="move_latitude">위도 </label>
						<input type="text" id="move_latitude" name="move_latitude" size="15"/> 
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 110px; padding-right: 12px;">
						<label for="move_longitude">경도 </label>
						<input type="text" id="move_longitude" name="move_longitude" size="15"/>
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 110px; padding-right: 12px;">
						<label for="move_height">높이 </label>
						<input type="text" id="move_height" name="move_height" size="15" />
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 97px; padding-right: 12px;">
						<label for="move_heading">HEADING </label>
						<input type="text" id="move_heading" name="move_heading" size="15" />
					</span> 
				</div>
				<div style="margin-top: 5px;">
					<span style="padding-left: 110px; padding-right: 12px;">
						<label for="move_pitch">PITCH </label>
						<input type="text" id="move_pitch" name="move_pitch" size="15" />
					</span>
				</div> 
				<div style="margin-top: 5px;">
					<span style="padding-left: 110px; padding-right: 12px;">
						<label for="move_roll">ROLL </label>
						<input type="text" id="move_roll" name="move_roll" size="15" /> 
						<button type="button" id="changeLocationAndRotationAPI">변환</button>
					</span>
				</div>
			</div>
			<div style="height: 20px;"></div>
		</div>
	</div>
		
	<div class="trigger" style="right: 10px;">
		<button type="button"></button>
		<ul>
			<li><a href="/homepage/tutorials.do">Tutorials</a></li>
			<li><a href="/homepage/download.do">Download</a></li>
			<li><a href="/homepage/about.do">mago3D</a></li>
			<li><a href="/homepage/index.do">Home</a></li>	
		</ul>
	</div>

	<div class="shortcut" style="top:60px;">
		<p>바로가기</p>
		<ul>
<c:forEach var="dataGroup" items="${projectDataGroupList}" varStatus="status">
			<li onclick="flyTo('${dataGroup.longitude}', '${dataGroup.latitude}', '${dataGroup.height}', '${dataGroup.duration}')">${dataGroup.data_group_name }</li>
</c:forEach>
		</ul>
	</div>	

	<!-- 맵영역 -->
	<div style="position: absolute; width: 100%; height: 100%; margin-top: 0; padding: 0; overflow: hidden;">
		<canvas id="magoContainer" style="width: 100%; height: auto">
	        Your browser does not support HTML5 Canvas.
	    </canvas>
	</div>

	<form:form id="issue" modelAttribute="issue" method="post" onsubmit="return false;">
	<div id="inputIssueLayer" style="display: none; top:40%; left:45%; width:450px; margin:-250px 0 0 -150px; " class="layer">
	    <div class="layerHeader">
	        <h2>Issue Register</h2>
	        <div>
	            <button id="inputIssueClose" type="button" title="닫기">닫기</button>
	        </div>
	    </div>
	    <div class="layerContents">
<!-- 	        <h4>테이블</h4> -->
	        <table>
	        	<tr>
	        		<th style="width: 120px;">
	        			<form:label path="data_group_id">데이터 그룹</form:label>
	        			<span class="icon-glyph glyph-emark-dot color-warning"></span>
	        		</th>
	        		<td>
	        			<form:select path="data_group_id" cssClass="select">
<c:forEach var="dataGroup" items="${projectDataGroupList}">
										<option value="${dataGroup.data_group_id}">${dataGroup.data_group_name}</option>
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
										<option value="${commonCode.code_value}">${commonCode.code_value}</option>
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
	        			<form:label path="title">제목</form:label>
	        			<span class="icon-glyph glyph-emark-dot color-warning"></span>
	        		</th>
	        		<td><form:input path="title" cssClass="ml" />
						<form:errors path="title" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="priority">Issue Type</form:label></th>
	        		<td>
	        			<form:select path="priority" cssClass="select">
<c:forEach var="commonCode" items="${issuePriorityList}">
							<option value="${commonCode.code_value}">${commonCode.code_value}</option>
</c:forEach>
						</form:select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="due_date">마감일</form:label></th>
	        		<td><form:hidden path="start_date" />
						<input type="text" id="start_day" name="start_day" placeholder="날짜" size="7" maxlength="4" />
						<input type="text" id="start_hour" name="start_hour" placeholder="시간" size="3" maxlength="2" />
						<span class="delimeter">:</span>
						<input type="text" id="start_minute" name="start_minute" placeholder="분" size="3" maxlength="2" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="assignee">Assignee</form:label></th>
	        		<td><form:input path="assignee" cssClass="m" placeholder="대리자" />
						<form:errors path="assignee" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="reporter">reporter</form:label></th>
	        		<td><form:input path="reporter" cssClass="m" placeholder="보고 해야 하는 사람" />
						<form:errors path="reporter" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr style="height: 50px;">
	        		<th><form:label path="contents">내용</form:label></th>
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

<script type="text/javascript" src="/externlib/${lang}/webworldwind/worldwind.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Code.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/API.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Config.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Callback.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Constant.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Message.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ManagerFactory.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Atmosphere.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeometryUtil.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeometryModifier.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Line.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Plane.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Point3D.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Shader.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ShaderSource.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ReaderWriter.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Renderer.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Selection.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VBOManager.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/CesiumManager.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/PostFxShader.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/FBO.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Geometry.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Accessor.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/NeoTexture.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/BoundingBox.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/BlockModels.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/FileRequestControler.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ManagerUtils.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/NeoReferenceModels.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/OcclusionCullOctree.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Octree.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VisibleObjectsControler.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Matrix4.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Lego.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Camera.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeoLocationData.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/MagoFacade.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Policy.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Box.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Vertex.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Triangle.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TriSurface.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TriPolyhedron.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VertexList.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VertexMatrix.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Color.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Quaternion.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/domain/ProjectLayer.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/MetaData.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/SceneState.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/SplitValue.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Frustum.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeographicCoord.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TerranTile.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GlobeTile.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Sphere.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ObjectMarker.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Pin.js"></script>
<script>
	var agent = navigator.userAgent.toLowerCase();
	if(agent.indexOf('chrome') < 0) { 
		alert("이 데모 페이지는 대용량 웹 데이터 처리를 위해 Chrome 브라우저에 최적화 되어 있습니다. \n원활한 서비스 이용을 위해 Chrome 브라우저를 이용  하시기 바랍니다.");
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
	
	function flyTo(longitude, latitude, height, duration) {
		managerFactory.flyTo(longitude, latitude, height, duration);
	}
	
	// 이슈 등록
	$("#issueEnable").click(function() {
		if(insertIssueFlag) {
			insertIssueFlag = false;
			//$("#issueEnable").val("Issue 등록");
			$("#issueEnable").removeClass("on");
		} else {
			insertIssueFlag = true;
			//$("#issueEnable").val("Issue 등록중");
			$("#issueEnable").addClass("on");
		}
		changeInsertIssueModeAPI(insertIssueFlag);
	});
	// object info 표시
	$("#objectInfoEnable").click(function() {
		if(objectInfoViewFlag) {
			objectInfoViewFlag = false;
			$("#objectInfoEnable").removeClass("on");
			//$("#objectInfoEnableLabel").text("Object 정보 표시");
		} else {
			objectInfoViewFlag = true;
			//$("#objectInfoEnableLabel").text("활성화 상태");
			$("#objectInfoEnable").addClass("on");			
		}
		changeObjectInfoViewModeAPI(objectInfoViewFlag);
	});
	// issue list 표시
	$("#issuesEnable").click(function() {
		alert("준비중 입니다.");
		return;
		if(listIssueFlag) {
			listIssueFlag = false;
			$("#issuesEnable").removeClass("on");
			//$("#issuesEnableLabel").text("Issue 목록");
		} else {
			listIssueFlag = true;
			$("#issuesEnable").addClass("on");
			//$("#issuesEnableLabel").text("활성화 상태");
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
				
				console.log("data_name = " + data_name + ", data_key = " + data_key + ", latitude = " + latitude + ", longitude = " + longitude + ", height = " + height); 
			}
		}
	}
	
	$("#inputIssueClose").click(function() {
		$("#inputIssueLayer").hide();
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
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	
	// Data 검색
	$("#searchData").click(function() {
		if ($.trim($("#search_data_key").val()) === ""){
			alert("Data Key를 입력해 주세요.");
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
			alert("Data Key를 입력해 주세요.");
			$("#move_data_key").focus();
			return false;
		}
		if ($.trim($("#move_latitude").val()) === ""){
			alert("위도를 입력해 주세요.");
			$("#move_latitude").focus();
			return false;
		}
		if ($.trim($("#move_longitude").val()) === ""){
			alert("경도를 입력해 주세요.");
			$("#move_longitude").focus();
			return false;
		}
		if ($.trim($("#move_height").val()) === ""){
			alert("높이를 입력해 주세요.");
			$("#move_height").focus();
			return false;
		}
		if ($.trim($("#move_heading").val()) === ""){
			alert("heading을 입력해 주세요.");
			$("#move_heading").focus();
			return false;
		}
		if ($.trim($("#move_pitch").val()) === ""){
			alert("pitch를 입력해 주세요.");
			$("#move_pitch").focus();
			return false;
		}
		if ($.trim($("#move_roll").val()) === ""){
			alert("roll를 입력해 주세요.");
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
						content += 	"<div style=\"text-align: center; padding-top:20px; height: 50px;\">"
								+	"	Issue가 존재하지 않습니다."
								+	"</div>";
					} else {
						for(i=0; i<issueList.length; i++ ) {
							var issue = null;
							issue = issueList[i];
							content = content 
								+ 	"<div style=\"padding-left: 20px; padding-top: 20px; padding-bottom: 20px; background: gainsboro\">"
								+ 	"	<div>"
								+ 	"		<img src=\"/images/${lang }/homepage/bullet_h4.png\" alt=\"\" />"
								+ 	"		<span style=\"padding-left: 10px; width:200px; overflow: hidden;\">" + issue.title + "</span>"
								+ 	"		<span style=\"float:right; padding-right: 15px; padding-top: 5px;\">"
								+ 	"			<a href=\"#\" onclick=\"flyTo('" + issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2')\">"
								+ 	"				<img src=\"/images/${lang }/homepage/btn_going.png\" width=\"26\" height=\"26\" alt=\"\" />"
								+ 	"			</a>"
								+ 	"		</span>"
								+ 	"	</div>"
								+ 	"	<div id=\"issue_toggle_" + issue.issue_id + "\">"
								+ 	"		<span style=\"padding-left: 25px;\">[" +  issue.issue_type + "][" + issue.priority + "]</span>"
								+ 	"		<span style=\"padding-left: 5px;\">" + issue.data_group_name  + "</span>"
								+ 	"		<span style=\"float:right; padding-right: 20px;\">" + issue.insert_date.substring(0,19) + "</span>"
								+ 	"	</div>"
								+ 	"</div>";
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