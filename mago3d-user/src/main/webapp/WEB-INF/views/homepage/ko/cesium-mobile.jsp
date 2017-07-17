<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- <meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="-1"/>
	<meta http-equiv="Pragma" content="no-cache"/> -->
	<title>demo | mago3D User</title>
	<link rel="stylesheet" href="/css/${lang}/homepage-demo.css" />
	<link rel="stylesheet" href="/externlib/${lang}/cesium/Widgets/widgets.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-mobile/jquery.mobile-1.4.5.min.css">
	<script src="/externlib/${lang}/jquery-mobile/jquery.min.js"></script>
	<script src="/externlib/${lang}/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-toast/jquery.toast.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<div data-role="page" class="jqm-demos" data-quicklinks="true">
		<!-- default panel  -->
		<div data-role="panel" id="defaultpanel">
			<h3>Default panel options</h3>
			<p>
				This panel has all the default options: positioned on the left with
				the reveal display mode. The panel markup is <em>before</em> the
				header, content and footer in the source order.
			</p>
			<p>To close, click off the panel, swipe left or right, hit the
				Esc key, or use the button below:</p>
			<a href="#demo-links" data-rel="close"
				class="ui-btn ui-shadow ui-corner-all ui-icon-delete ui-btn-icon-left ui-btn-inline">Close
				panel</a>
		</div>
		<!-- /default panel -->

		<div role="main" class="ui-content jqm-content"
			style="width: 100%; height100 %; margin-top: 0; padding: 0; overflow: hidden;">
			<div id="magoContainer"
				style="position: absolute; width: 100%; height: 100%; margin-top: 0; padding: 0; overflow: hidden;"></div>
			<a href="#leftpanel1"
				class="ui-btn ui-shadow ui-corner-all ui-btn-inline ui-mini">Reveal</a>
		</div>

		<!-- leftpanel1  -->
		<div data-role="panel" id="leftpanel1" data-position="left"
			data-display="overlay" data-theme="a">
			<div data-role="content">
					<ul data-role="listview">
					  <li data-role="collapsible" data-iconpos="right" data-inset="false">
					    <h2>Birds</h2>
					    <ul data-role="listview" data-theme="b">
					      <li class="ui-frist-child"><a href="#" class="ui-btn ui-btn-icon-right ui-icon-carat-r">"Condor"</a></li>
					      <li><a href="#">Eagle</a></li>
					      <li class="ui-last-child"><a href="#">Sparrow</a></li>
					    </ul>
					  </li>
					  <li><a href="#">Humans</a></li>
					  <li data-role="collapsible" data-iconpos="right" data-inset="false">
					    <h2>Fish</h2>
					    <ul data-role="listview" data-theme="b">
					      <li><a href="#">Salmon</a></li>
					      <li><a href="#">Pollock</a></li>
					      <li><a href="#">Trout</a></li>
					    </ul>
					  </li>
					  <li data-role="collapsible" data-iconpos="right" data-inset="false">
					    <h2>Choose your preference</h2>
					    <form>
					      <fieldset data-role="controlgroup" data-type="horizontal">
					        <label>Birds<input type="checkbox" id="choose-birds-regular"></label>
					        <label>Humans<input type="checkbox" id="choose-humans-regular"></label>
					        <label>Fish<input type="checkbox" id="choose-fish-regular"></label>
					      </fieldset>
					    </form>
					  </li>
					</ul>    
			</div>
			<!-- 				<form> -->
			<!-- 					<ul data-role="listview" data-inset="true"> -->
			<!--                         <li class="ui-field-contain"> -->
			<!--                             <label for="name2">Text Input:</label> -->
			<!--                             <input type="text" name="name2" id="name2" value="" data-clear-btn="true"> -->
			<!--                         </li> -->
			<!--                         <li class="ui-field-contain"> -->
			<!--                             <label for="textarea2">Textarea:</label> -->
			<!--                         <textarea cols="40" rows="8" name="textarea2" id="textarea2"></textarea> -->
			<!--                         </li> -->
			<!--                         <li class="ui-field-contain"> -->
			<!--                             <label for="flip2">Flip switch:</label> -->
			<!--                             <select name="flip2" id="flip2" data-role="slider"> -->
			<!--                                 <option value="off">Off</option> -->
			<!--                                 <option value="on">On</option> -->
			<!--                             </select> -->
			<!--                         </li> -->
			<!--                         <li class="ui-field-contain"> -->
			<!--                             <label for="slider2">Slider:</label> -->
			<!--                             <input type="range" name="slider2" id="slider2" value="0" min="0" max="100" data-highlight="true"> -->
			<!--                         </li> -->

			<!--                         <li class="ui-field-contain"> -->
			<!--                             <label for="select-choice-1" class="select">Choose shipping method:</label> -->
			<!--                             <select name="select-choice-1" id="select-choice-1"> -->
			<!--                                 <option value="standard">Standard: 7 day</option> -->
			<!--                                 <option value="rush">Rush: 3 days</option> -->
			<!--                                 <option value="express">Express: next day</option> -->
			<!--                                 <option value="overnight">Overnight</option> -->
			<!--                             </select> -->
			<!--                         </li> -->
			<!--                         <li class="ui-body ui-body-b"> -->
			<!--                             <fieldset class="ui-grid-a"> -->
			<!--                                     <div class="ui-block-a"><button type="submit" class="ui-btn ui-corner-all ui-btn-a">Cancel</button></div> -->
			<!--                                     <div class="ui-block-b"><button type="submit" class="ui-btn ui-corner-all ui-btn-a">Submit</button></div> -->
			<!--                             </fieldset> -->
			<!--                         </li> -->
			<!-- 					</ul> -->
			<!-- 				</form> -->
			<a href="#demo-links" data-rel="close"
				class="ui-btn ui-shadow ui-corner-all ui-btn-a ui-icon-delete ui-btn-icon-left ui-btn-inline">Close
				panel</a>
		</div>
		<!-- /leftpanel1 -->
	</div>
<script type="text/javascript" src="/externlib/${lang}/cesium/Cesium.js"></script>
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
								drawInsertIssueImageAPI(issue.issue_id, issue.issue_type, issue.data_key, issue.latitude, issue.longitude, issue.height);
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
						drawInsertIssueImageAPI(msg.issue.issue_id, msg.issue.issue_type, $("#data_key").val(), $("#latitude").val(), $("#longitude").val(), $("#height").val());
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
								+ 	"			<a href=\"#\" onclick=\"flyTo('" + issue.issue_id + "', '" + issue.issue_type 
													+ "', '" + issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2')\">"
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