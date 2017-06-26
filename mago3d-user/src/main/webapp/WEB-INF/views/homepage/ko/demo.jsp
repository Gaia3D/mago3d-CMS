<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Mago3D User</title>
	<%-- <link rel="stylesheet" href="/css/${lang}/font/font.css" /> --%>
<%-- 	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" /> --%>
<%-- 	<link rel="stylesheet" href="/css/${lang}/style.css" /> --%>
<!-- 	<link rel="stylesheet" href="/sample/style.css" /> -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans"> 
	<link rel="stylesheet" href="/css/${lang}/homepage-demo.css" />
	
	<link rel="stylesheet" href="/externlib/${lang}/jquery-toast/jquery.toast.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-toast/jquery.toast.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<link rel="stylesheet" href="/externlib/${lang}/cesium/Widgets/widgets.css" />
</head>

<body>

	<div class="trigger" >
		<button type="button"></button>
		<ul>
			<li><a href="/homepage/tutorials.do">Tutorials</a></li>
			<li><a href="/homepage/download.do">Download</a></li>
			<li><a href="/homepage/about.do">Mago3D</a></li>
			<li>Home</li>	
		</ul>
	</div>

	<ul class="dropdownmenu">
<c:forEach var="dataGroup" items="${projectDataGroupList}">
		<li>${dataGroup.data_group_name}
			<ul>
				<li>BoundingBox 표시</li>
				<li>색깔 변경</li>
				<li>위치 변환</li>
			</ul>
		</li>
</c:forEach>	
	</ul>

	<div id="magoControllArea">
		<div id="issueEnable" style="width: 150px;">
			<img src="/images/${lang }/homepage/issue_input.png" alt="Issue Input" width="40px;" height="50px;" />
			<p />
			<span id="issueEnableLabel" style="margin-top: 5px; width: 50px; bold; color: #FFFFFF;">Issue 등록</span>
		</div>
		<div id="objectInfoEnable" style="margin-top:20px; width:150px;">
			<img src="/images/${lang }/homepage/info_view.png" alt="Info View" width="40px;" height="50px;" />
			<p />
			<span id="objectInfoEnableLabel" style="margin-top: 5px; width: 50px; bold; color: #FFFFFF;">Object 정보 표시</span>
		</div>
		<div id="issuesEnable" style="margin-top:20px; width:150px;">
			<img src="/images/${lang }/homepage/issue_list.png" alt="Info View" width="40px;" height="50px;" />
			<p />
			<span id="issuesEnableLabel" style="margin-top: 5px; width: 50px; bold; color: #FFFFFF;">Issue 목록</span>
		</div>
		
		<div style="margin-top:50px; width:150px;" onclick="inputIssue();">
			<span style="margin-top: 5px; width: 50px; bold; color: #FFFFFF;">API Call Test</span>
		</div>
	</div>
	
	<!-- 맵영역 -->
	<div id="magoContainer" style="position: absolute; width: 99%; height: 95%; margin-top: 0; padding: 0; overflow: hidden;"></div>

	<form:form id="issue" modelAttribute="issue" method="post" onsubmit="return false;">
	<div id="inputIssueLayer" style="display: none; top:40%; left:10%; width:450px; margin:-250px 0 0 -150px; " class="layer">
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
	        		<th style="width: 100px;"><form:label path="data_group_id">데이터 그룹</form:label></th>
	        		<td>
	        			<form:select path="data_group_id" cssClass="select">
<c:forEach var="dataGroup" items="${projectDataGroupList}">
										<option value="${dataGroup.data_group_id}">${dataGroup.data_group_name}</option>
</c:forEach>
									</form:select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="issue_type">Issue Type</form:label></th>
	        		<td>
	        			<form:select path="issue_type" cssClass="select">
<c:forEach var="commonCode" items="${issueTypeList}">
										<option value="${commonCode.code_value}">${commonCode.code_value}</option>
</c:forEach>
						</form:select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="data_key">Data Key</form:label></th>
	        		<td><form:input path="data_key" cssClass="l" />
						<form:errors path="data_key" cssClass="error" />
						<form:hidden path="latitude"/>
						<form:hidden path="longitude"/>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="title">제목</form:label></th>
	        		<td><form:input path="title" cssClass="xl" size="40" />
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
						<input type="text" id="start_hour" name="start_hour" class="s" placeholder="시간" size="5" maxlength="2" />
						<span class="delimeter">:</span>
						<input type="text" id="start_minute" name="start_minute" class="s" placeholder="분" size="5" maxlength="2" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="assignee">Assignee</form:label></th>
	        		<td><form:input path="assignee" cssClass="l" placeholder="대리자" />
						<form:errors path="assignee" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="reporter">reporter</form:label></th>
	        		<td><form:input path="reporter" cssClass="l" placeholder="보고 해야 하는 사람" />
						<form:errors path="reporter" cssClass="error" />
	        		</td>
	        	</tr>
	        	<tr>
	        		<th><form:label path="contents">내용</form:label></th>
	        		<td>
	        			<form:textarea path="contents" cols="40" rows="3" />
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

<script type="text/javascript" src="/externlib/${lang}/cesium/Cesium.js"></script>
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
<script>
	var policyJson = ${policyJson};
	var dataGroupMap = ${dataGroupMap};
	var insertIssueFlag = false;
	var objectInfoViewFlag = false;
	var listIssueFlag = false;
	var managerFactory = new ManagerFactory(null, "magoContainer", policyJson, dataGroupMap);
	
	// 이슈 등록
	$("#issueEnable").click(function() {
		if(insertIssueFlag) {
			insertIssueFlag = false;
			$("#issueEnableLabel").text("Issue 등록");
		} else {
			insertIssueFlag = true;
			$("#issueEnableLabel").text("활성화 상태");
		}
		changeInsertIssueModeAPI(insertIssueFlag);
	});
	// object info 표시
	$("#objectInfoEnable").click(function() {
		if(objectInfoViewFlag) {
			objectInfoViewFlag = false;
			$("#objectInfoEnableLabel").text("Object 정보 표시");
		} else {
			objectInfoViewFlag = true;
			$("#objectInfoEnableLabel").text("활성화 상태");
		}
		changeObjectInfoViewModeAPI(objectInfoViewFlag);
	});
	// issue list 표시
	$("#issuesEnable").click(function() {
		if(listIssueFlag) {
			listIssueFlag = false;
			$("#issuesEnableLabel").text("Issue 목록");
		} else {
			listIssueFlag = true;
			$("#issuesEnableLabel").text("활성화 상태");
		}
		changeListIssueViewModeAPI(listIssueFlag);
	});
	
	function inputIssue(data_name, data_key, latitude, longitude, elevation) {
		if(insertIssueFlag) {
			if($("#inputIssueLayer").css("display") == "none") {
				$("#inputIssueLayer").show();
				
				var dt = new Date();
				
				$("#data_name").val(dt.getFullYear() + "/" + (dt.getMonth()+1) + "/" + dt.getDate() + " " + dt.getHours() + "-" + dt.getMinutes() + "-" + dt.getSeconds());
				$("#data_key").val(dt.getFullYear() + "/" + (dt.getMonth()+1) + "/" + dt.getDate() + " " + dt.getHours() + "-" + dt.getMinutes() + "-" + dt.getSeconds());
				$("#latitude").val("37.57750");
				$("#longitude").val("126.89069");
				$("#elevation").val("60.0");
			}
		}
	}
	
	$("#inputIssueClose").click(function() {
		$("#inputIssueLayer").hide();
	});
	
	// object 정보 표시 call back function
	function showSelectedObject(projectId, blockId, objectId, latitude, longitude, elevation, heading, pitch, roll){
		if(objectInfoViewFlag) {
			$.toast({
			    heading: 'How to contribute?!',
			    text: [
			        'projectId : ' + projectId, 
			        'blockId : ' + blockId, 
			        'objectId : ' + objectId,
			        'latitude : ' + latitude,
			        'longitude : ' + longitude,
			        'elevation : ' + elevation,
			        'heading : ' + heading,
			        'pitch : ' + pitch,
			        'roll : ' + roll
			    ],
				//bgColor : 'blue',
				hideAfter: 5000,
				icon: 'info'
			})
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
		if ($("#assignee").val() == "") {
			alert(JS_MESSAGE["issue.assignee.empty"]);
			$("#assignee").focus();
			return false;
		}
		if ($("#reporter").val() == "") {
			alert(JS_MESSAGE["issue.reporter.empty"]);
			$("#reporter").focus();
			return false;
		}
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
	
	var insertIssueFlag = true;
	function insertIssue() {
		if (check() == false) {
			return false;
		}
		if(insertIssueFlag) {
			insertIssueFlag = false;
			var info = $("#issue").serialize();		
			$.ajax({
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					
					$("#inputIssueLayer").hide();
					insertIssueFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertIssueFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}	
	}
</script>
</body>
</html>